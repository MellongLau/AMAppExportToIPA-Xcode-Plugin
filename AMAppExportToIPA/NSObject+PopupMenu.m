//
//  NSObject+PopupMenu.m
//
//  Created by Mellong on 16/2/15.
//  Copyright © 2016年 Tendencystudio. All rights reserved.
//

#import "NSObject+PopupMenu.h"
#import "NSObject+MethodSwizzler.h"
#import <Cocoa/Cocoa.h>
#import <APPKit/NSMenu.h>
#import <objc/runtime.h>

NSString *const kAMProjectNavigatorContextualMenu = @"Project navigator contextual menu";
NSString *const kAMExportIPA = @"Export IPA";

static void *kAMFilePath;
static void *kAMBuildTask;

@interface NSObject ()

@property (nonatomic, copy) NSString *am_filePath;
@property (nonatomic, strong) __block NSTask *am_buildTask;


- (void)addItem:(id)item;
- (void)_popUpContextMenu:(id)arg1 withEvent:(id)arg2 forView:(id)arg3 withFont:(id)arg4;

@end

@implementation NSMenu (AM_PopupMenu)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"NSMenu") am_swizzleWithOriginalSelector:@selector(_popUpContextMenu:withEvent:forView:withFont:) swizzledSelector:@selector(am_popUpContextMenu:withEvent:forView:withFont:) isClassMethod:NO];

        [NSClassFromString(@"NSMenu") am_swizzleWithOriginalSelector:@selector(addItem:) swizzledSelector:@selector(am_addItem:) isClassMethod:NO];
    });
}

- (NSString *)am_filePath {
    NSString *result = objc_getAssociatedObject(self, &kAMFilePath);
    return result;
}

- (void)setAm_filePath:(NSString *)am_filePath {
   objc_setAssociatedObject(self, &kAMFilePath, am_filePath, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSTask *)am_buildTask {
    NSTask *result = objc_getAssociatedObject(self, &kAMBuildTask);
    return result;
}

- (void)setAm_buildTask:(NSTask *)am_buildTask {
    objc_setAssociatedObject(self, &kAMBuildTask, am_buildTask, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//Method call flow:
//      Init menu:  popUpContextMenu:withEvent:forView:withFont: > addItem:
//      Menu exist: popUpContextMenu:withEvent:forView:withFont:
//Project navigator contextual menu
- (void)am_addItem:(NSMenuItem *)item
{
    [self am_addItem:item];
    if ([self.title isEqualToString:kAMProjectNavigatorContextualMenu]) {
        [self addExportIPAMenuItemWithMenu:item.menu];
    }
   
}

- (void)am_popUpContextMenu:(NSMenu *)arg1 withEvent:(NSEvent *)arg2 forView:(NSView *)arg3 withFont:(id)arg4
{
    
    if ([arg3 isKindOfClass:NSClassFromString(@"IDENavigatorOutlineView")]) {

        IDENavigatorOutlineView *view = (IDENavigatorOutlineView *)arg3;
        NSArray<IDEFileReferenceNavigableItem *> *select = [view contextMenuSelectedItems];
        if ([select.firstObject respondsToSelector:@selector(fileURL)] && [select.firstObject.fileURL.absoluteString.pathExtension isEqualToString:@"app"]) {
            [self setAm_filePath:select.firstObject.fileURL.absoluteString];
        }else {
           [self setAm_filePath:@""];
        }
        //If menu exist, then update menu status.
        if ([self.title isEqualToString:kAMProjectNavigatorContextualMenu] && arg1.itemArray.count > 0 ) {
            [self addExportIPAMenuItemWithMenu:arg1];
        }
    }

   [self am_popUpContextMenu:arg1 withEvent:arg2 forView:arg3 withFont:arg4];
}

- (void)addExportIPAMenuItemWithMenu:(NSMenu *)menu
{
    NSString *filePath = [self am_filePath];
    
    NSMenuItem *item = [menu itemWithTitle:kAMExportIPA];
    if (item != nil)  {
        [menu removeItem:item];
    }
    
    SEL selector = [filePath.pathExtension isEqualToString:@"app"] ? @selector(generateIPA:): nil;
    NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:kAMExportIPA action:selector keyEquivalent:@""];
    [menu am_addItem:actionMenuItem];
    actionMenuItem.enabled = [filePath.pathExtension isEqualToString:@"app"];
    actionMenuItem.target = self;
    
}

- (void)generateIPA:(id)arg1 {
    
    NSProgressIndicator* indicator = [[NSProgressIndicator alloc] init];
    [indicator setStyle:NSProgressIndicatorSpinningStyle];
    NSWindowController *currentWindowController = [[NSApp keyWindow] windowController];
    if ([currentWindowController isKindOfClass:NSClassFromString(@"IDEWorkspaceWindowController")]) {
        [currentWindowController.window.contentView addSubview:indicator];
        [indicator setFrame:NSMakeRect(currentWindowController.window.contentView.frame.size.width/2.0, currentWindowController.window.contentView.frame.size.height/2.0, 30, 30)];
        [indicator startAnimation:self];
    }
    
    dispatch_queue_t taskQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    dispatch_async(taskQueue, ^{
        int status = 0;
        @try {
            NSString *filePath = self.am_filePath;
            
            //Trim file url string.
            filePath = [filePath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
            filePath = [filePath stringByReplacingOccurrencesOfString:@"/" withString:@"" options:0 range:NSMakeRange(filePath.length-2, 2)];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyyMMdd-HHmmss"];
            NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];
            
            NSString *fileName = [filePath.lastPathComponent substringWithRange:NSMakeRange(0, filePath.lastPathComponent.length-4)];
            NSString *decodeFilePath = [self URLDecode:filePath];
            NSString *targetFileName = [[self URLDecode:fileName] stringByReplacingOccurrencesOfString:@" " withString:@"-"];
            
            NSString *targetFilePath = [NSString stringWithFormat:@"%@-%@.ipa", targetFileName, dateString];
            
            NSString* shellPath =
            [[NSBundle bundleForClass:NSClassFromString(@"AMAppExportToIPAXcodePlugin")] pathForResource:@"Script"
                                                             ofType:@"sh"];
//            NSString *commands = [NSString stringWithFormat:@"mkdir ~/Desktop/AM_Builds;xcrun -sdk iphoneos PackageApplication -v \"%@\" -o %@;open -R %@",
//                                  decodeFilePath,
//                                  targetFilePath,
//                                  targetFilePath];
//            
            //Excute shell task
            self.am_buildTask = [[NSTask alloc] init];
            [self.am_buildTask setLaunchPath:@"/bin/bash"];
            [self.am_buildTask setArguments:@[shellPath, decodeFilePath, targetFilePath]];
            [self.am_buildTask launch];
            [self.am_buildTask waitUntilExit];
            
            //Launch result
            status = [self.am_buildTask terminationStatus];

            
        }@catch (NSException *exception) {
            NSLog(@"Problem Running Task: %@", [exception description]);
        }
        @finally {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [indicator stopAnimation:self];
                [indicator removeFromSuperview];
            });
            
            if (status == 0) {
                NSLog(@"Task succeeded.");
            }
            else {
                NSLog(@"Task failed.");
            }
        }
    });
}

- (NSString *)URLDecode:(NSString *)stringToDecode
{
    NSString *result = [stringToDecode stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

@end
