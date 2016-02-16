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

@interface NSObject ()

- (void)addItem:(id)item;
- (void)_popUpContextMenu:(id)arg1 withEvent:(id)arg2 forView:(id)arg3 withFont:(id)arg4;

@end

@implementation NSObject (AM_PopupMenu)

+ (void)load
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        [NSClassFromString(@"NSMenu") swizzleWithOriginalSelector:@selector(_popUpContextMenu:withEvent:forView:withFont:) swizzledSelector:@selector(AM_popUpContextMenu:withEvent:forView:withFont:) isClassMethod:NO];

        [NSClassFromString(@"NSMenu") swizzleWithOriginalSelector:@selector(addItem:) swizzledSelector:@selector(AM_addItem:) isClassMethod:NO];
    });
}

//Project Navigator Help
- (void)AM_addItem:(NSMenuItem *)item
{
    [self AM_addItem:item];
    NSString *filePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"AMFilePath"];
    
    NSString *title = @"Export IPA";
    if ([[item title] isEqualToString:@"Project Navigator Help"]) {
        NSMenu *menu = item.menu;
        if ([menu itemWithTitle:title] != nil)  {
            [menu removeItem:[menu itemWithTitle:title]];
        }
        SEL selector = [filePath.pathExtension isEqualToString:@"app"]? @selector(addMenuItem:):nil;
        NSMenuItem *actionMenuItem = [[NSMenuItem alloc] initWithTitle:title action:selector keyEquivalent:@""];
        [menu addItem:actionMenuItem];
        actionMenuItem.target = self;
        
    }
}

- (void)AM_popUpContextMenu:(NSMenu *)arg1 withEvent:(NSEvent *)arg2 forView:(NSView *)arg3 withFont:(id)arg4
{

    if ([arg3 isKindOfClass:NSClassFromString(@"IDENavigatorOutlineView")]) {
        [arg1 removeAllItems];
        IDENavigatorOutlineView *view = (IDENavigatorOutlineView *)arg3;
        NSArray<IDEFileReferenceNavigableItem *> *select = [view contextMenuSelectedItems];
        if ([select.firstObject respondsToSelector:@selector(fileURL)]) {
            [[NSUserDefaults standardUserDefaults] setObject:select.firstObject.fileURL.absoluteString forKey:@"AMFilePath"];
        }else {
           [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"AMFilePath"];
        }
        
    }
    [self AM_popUpContextMenu:arg1 withEvent:arg2 forView:arg3 withFont:arg4]; 
}

- (void)addMenuItem:(id)arg1 {
    
    NSString *filePath = [[NSUserDefaults standardUserDefaults] objectForKey:@"AMFilePath"];
    
    //Trim file url string.
    filePath = [filePath stringByReplacingOccurrencesOfString:@"file://" withString:@""];
    filePath = [filePath stringByReplacingOccurrencesOfString:@"/" withString:@"" options:0 range:NSMakeRange(filePath.length-2, 2)];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd-HHmmss"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate date]];

    NSString *fileName = [filePath.lastPathComponent substringWithRange:NSMakeRange(0, filePath.lastPathComponent.length-4)];
    NSString *commands = [NSString stringWithFormat:@"mkdir ~/Desktop/AM_Builds;xcrun -sdk iphoneos PackageApplication -v \"%@\" -o ~/Desktop/AM_Builds/%@-%@.ipa;open ~/Desktop/AM_Builds/", filePath, fileName, dateString];
    
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


@end
