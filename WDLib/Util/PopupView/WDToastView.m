//
//  WDToastView.m
//  WDLib
//
//  Created by wandou on 20/12/2017.
//  Copyright © 2017 wandou. All rights reserved.
//

#import "WDToastView.h"

static WDToastView *single = nil;

@implementation WDToastView

+(id)shareInstance {
    
    @synchronized(self){//同步操作，保证线程安全
        if (single == nil) {
            single = [[WDToastView alloc]init];
        }
    }
    
    return single;
}

//重写allocWithZone方法
+(instancetype)allocWithZone:(struct _NSZone *)zone {
    
    if (single == nil) {
        single = [super allocWithZone:zone];
    }
    
    return single;
}

+(void)releaseSingle {
    
    if (single != nil) {
        single = nil;
    }
}

-(void)addTitle:(NSString *)title addView:(UIView *)view{
    
    if (titleLabel != nil) {
        
        return;
    }
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    titleLabel.layer.cornerRadius = 8;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.font = WD_FONTTSIZE(16);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    titleLabel.text = title;
    CGSize size = [titleLabel sizeThatFits:CGSizeMake(view.frame.size.width - 100, 0)];
    titleLabel.frame = CGRectMake(0, 0, size.width + 20, size.height + 20);
    titleLabel.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 4);
    [view addSubview:titleLabel];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [titleLabel removeFromSuperview];
        titleLabel = nil;
    });
}

-(void)addKeyboardTitle:(NSString *)title addView:(UIView *)view {
    
    if (titleLabel != nil) {
        
        return;
    }
    titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    titleLabel.layer.cornerRadius = 8;
    titleLabel.layer.masksToBounds = YES;
    titleLabel.font = WD_FONTTSIZE(16);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    titleLabel.text = title;
    CGSize size = [titleLabel sizeThatFits:CGSizeMake(view.frame.size.width - 100, 0)];
    titleLabel.frame = CGRectMake(0, 0, size.width + 20, size.height + 20);
    titleLabel.center = CGPointMake(view.frame.size.width / 2, view.frame.size.height / 2);
    [view addSubview:titleLabel];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [titleLabel removeFromSuperview];
        titleLabel = nil;
    });
    
}

@end
