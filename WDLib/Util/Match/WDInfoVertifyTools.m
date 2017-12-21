//
//  WDInfoVertifyTools.m
//  WDLib
//
//  Created by wandou on 19/12/2017.
//  Copyright © 2017 wandou. All rights reserved.
//

#import "WDInfoVertifyTools.h"

@implementation WDInfoVertifyTools
+ (BOOL)isnilVertify:(NSString *)string{
    
    if ([@"" isEqualToString:string] || nil == string || 0 == string.length) {
        return YES;
    } else {
        return NO;
    }
}


@end
