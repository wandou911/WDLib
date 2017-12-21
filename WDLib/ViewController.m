//
//  ViewController.m
//  WDLib
//
//  Created by wandou on 19/12/2017.
//  Copyright © 2017 wandou. All rights reserved.
//

#import "ViewController.h"
#import "WDLoadingView.h"
#import "WDToastView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[[WDLoadingView shareInstance] addLoadingViewForView:self.view withTitle:@""];
    
    [[WDToastView shareInstance] addTitle:@"暂无数据" addView:self.view];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
