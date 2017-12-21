//
//  WDLoadingView.h
//  WDLib
//
//  Created by wandou on 19/12/2017.
//  Copyright © 2017 wandou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WDLoadingView : UIView{
    
    UIView *loadingView;
    UIActivityIndicatorView *indicatorView;
    UILabel *titleLabel;
    UIImageView *animationImageView;
}

+ (id)shareInstance;
- (void)addLoadingViewForView:(UIView *)view withTitle:(NSString *)title;
- (void)removeLoadingView;
@end
