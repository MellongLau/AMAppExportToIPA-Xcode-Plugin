//
//  NSObject_Extension.m
//  AMAppExportToIPAXcodePlugin
//
//  Created by Mellong on 16/2/16.
//  Copyright © 2016年 Tendencystudio. All rights reserved.
//


#import "NSObject_Extension.h"
#import "AMAppExportToIPAXcodePlugin.h"

@implementation NSObject (Xcode_Plugin_Template_Extension)

+ (void)pluginDidLoad:(NSBundle *)plugin
{
    static dispatch_once_t onceToken;
    NSString *currentApplicationName = [[NSBundle mainBundle] infoDictionary][@"CFBundleName"];
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            sharedPlugin = [[AMAppExportToIPAXcodePlugin alloc] initWithBundle:plugin];
        });
    }
}
@end
