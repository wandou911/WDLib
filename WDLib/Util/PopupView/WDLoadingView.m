//
//  WDLoadingView.m
//  WDLib
//
//  Created by wandou on 19/12/2017.
//  Copyright © 2017 wandou. All rights reserved.
//

#import "WDLoadingView.h"

static WDLoadingView * loadView;

@implementation WDLoadingView

+ (id)shareInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadView = [[WDLoadingView alloc] initWithFrame:CGRectMake(0, 0, WD_SCREEN_WIDTH, WD_SCREEN_HEIGHT)];
    });
    
    return loadView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //背景框
        loadingView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 130 * WD_WIDTH_BASE,110* WD_HEIGHT_BASE)];
        loadingView.layer.cornerRadius = 10 * WD_HEIGHT_BASE;
        loadingView.layer.masksToBounds = YES;
        loadingView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
        loadingView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self addSubview:loadingView];
        
        //转转的菊花
        indicatorView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        indicatorView.center=CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 4 + 5 * WD_HEIGHT_BASE);
        [loadingView addSubview:indicatorView];
        
        //文字
        titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, loadingView.frame.size.height / 2, loadingView.frame.size.width,loadingView.frame.size.height / 2)];
        titleLabel.backgroundColor=[UIColor clearColor];
        titleLabel.font=WD_FONTTSIZE(16);
        titleLabel.textAlignment=NSTextAlignmentCenter;
        titleLabel.textColor=[UIColor whiteColor];
        [loadingView addSubview:titleLabel];
        
    }
    
    return self;
}

- (void)addLoadingViewForView:(UIView *)view withTitle:(NSString *)title{
    
    [self removeFromSuperview];
    self.frame=view.bounds;
    loadingView.frame = CGRectMake(0, 0, 130 * WD_WIDTH_BASE, 110 *WD_HEIGHT_BASE);
    loadingView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    indicatorView.center=CGPointMake(loadingView.frame.size.width / 2, loadingView.frame.size.height / 4  + 5 * WD_HEIGHT_BASE);
    titleLabel.frame = CGRectMake(0, loadingView.frame.size.height / 2, loadingView.frame.size.width,loadingView.frame.size.height / 2);
    [indicatorView startAnimating];
    titleLabel.text = title;
    [view addSubview:self];
}

- (void)removeLoadingView{
    
    [indicatorView stopAnimating];
    loadingView.hidden = NO;
    [self removeFromSuperview];
}


@end
