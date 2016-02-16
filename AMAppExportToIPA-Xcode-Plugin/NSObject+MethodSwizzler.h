//
//  NSObject+MethodSwizzler.h
//
//  Created by Mellong on 16/2/15.
//  Copyright © 2016年 Tendencystudio. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface NSObject (MethodSwizzler)

+ (void)swizzleWithOriginalSelector:(SEL)originalSelector
                   swizzledSelector:(SEL) swizzledSelector
                      isClassMethod:(BOOL)isClassMethod;

@end
