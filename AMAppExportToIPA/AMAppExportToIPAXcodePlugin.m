//
//  AMAppExportToIPAXcodePlugin.m
//  AMAppExportToIPAXcodePlugin
//
//  Created by Mellong on 16/2/16.
//  Copyright © 2016年 Tendencystudio. All rights reserved.
//

#import "AMAppExportToIPAXcodePlugin.h"

@interface AMAppExportToIPAXcodePlugin()

@property (nonatomic, strong, readwrite) NSBundle *bundle;
@end

@implementation AMAppExportToIPAXcodePlugin

+ (instancetype)sharedPlugin
{
    return sharedPlugin;
}

- (id)initWithBundle:(NSBundle *)plugin
{
    if (self = [super init]) {
        // reference to plugin's bundle, for resource access
        self.bundle = plugin;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didApplicationFinishLaunchingNotification:)
                                                     name:NSApplicationDidFinishLaunchingNotification
                                                   object:nil];
    }
    return self;
}

- (void)didApplicationFinishLaunchingNotification:(NSNotification*)noti
{
    //removeObserver
    [[NSNotificationCenter defaultCenter] removeObserver:self name:NSApplicationDidFinishLaunchingNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
