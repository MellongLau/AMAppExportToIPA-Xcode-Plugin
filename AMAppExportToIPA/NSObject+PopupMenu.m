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
//NSString *const kAMFilePath = @"AMFilePath";

static void *kAMFilePath;

@interface NSObject ()

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
- (void)set_am_filePath:(NSString *)filePath {
   objc_setAssociatedObject(self, &kAMFilePath, filePath, OBJC_ASSOCIATION_COPY_NONATOMIC);
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
            [self set_am_filePath:select.firstObject.fileURL.absoluteString];
        }else {
           [self set_am_filePath:@""];
        }
        //If menu exist, then update menu status.
        if ([self.title isEqualToString:kAMProjectNavigatorContextualMenu]) {
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
    
    NSString *filePath = [self am_filePath];
    
    //Trim file url string.
    filePath = [filePath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    filePath = [filePath stringByReplacingOccurrencesOfString:@"/" withString:@"" options:0 range:NSMakeRange(filePath.length-2, 2)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd-HHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];

    NSString *fileName = [filePath.lastPathComponent substringWithRange:NSMakeRange(0, filePath.lastPathComponent.length-4)];
    NSString *commands = [NSString stringWithFormat:@"mkdir ~/Desktop/AM_Builds;xcrun -sdk iphoneos PackageApplication -v \"%@\" -o ~/Desktop/AM_Builds/%@-%@.ipa;open ~/Desktop/AM_Builds/",
                          [self URLDecode:filePath],
                          [[self URLDecode:fileName] stringByReplacingOccurrencesOfString:@" " withString:@"-"],
                          dateString];
    
    //Excute shell task
    NSTask *task = [[NSTask alloc] init];
    [task setLaunchPath:@"/bin/bash"];
    [task setArguments:@[ @"-c", commands]];
    [task launch];
    [task waitUntilExit];
    
    //Launch result
    int status = [task terminationStatus];
    
    if (status == 0) {
        NSLog(@"Task succeeded.");
    }
    else {
        NSLog(@"Task failed.");
    }
}

- (NSString *)URLDecode:(NSString *)stringToDecode
{
    NSString *result = [stringToDecode stringByReplacingOccurrencesOfString:@"+" withString:@" "];
    result = [result stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    return result;
}

@end
