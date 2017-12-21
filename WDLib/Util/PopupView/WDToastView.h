//
//  WDToastView.h
//  WDLib
//
//  Created by wandou on 20/12/2017.
//  Copyright © 2017 wandou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDToastView : UIView
{
    UILabel *titleLabel;
}
+(id)shareInstance;
//释放当前的对象
+(void)releaseSingle;
-(void)addTitle:(NSString *)title addView:(UIView *)view;
-(void)addKeyboardTitle:(NSString *)title addView:(UIView *)view;

@end
