//
//  AMAppExportToIPAXcodePlugin.h
//  AMAppExportToIPAXcodePlugin
//
//  Created by Mellong on 16/2/16.
//  Copyright © 2016年 Tendencystudio. All rights reserved.
//

#import <AppKit/AppKit.h>

@class AMAppExportToIPAXcodePlugin;

static AMAppExportToIPAXcodePlugin *sharedPlugin;

@interface AMAppExportToIPAXcodePlugin : NSObject

+ (instancetype)sharedPlugin;
- (id)initWithBundle:(NSBundle *)plugin;

@property (nonatomic, strong, readonly) NSBundle* bundle;
@end