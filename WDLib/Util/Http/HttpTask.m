//
//  HttpTask.m
//  WD
//
//  Created by wandou on 2017/11/6.
//  Copyright © 2017年 wandou. All rights reserved.
//

#import "HttpTask.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"

@implementation HttpTask

+(void) doGetToServer:(NSString *) remoteStr
            needToken:(BOOL) needToken
          sucessBlock:(void (^)(NSString *))sucessCallback
            failBlock:(void (^)(NSDictionary *))failCallback{
    
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDefaultes stringForKey:@"usr.token"];
    
    NSString *jsessionid = [userDefaultes stringForKey:@"usr.jsessionid"];
    
    UIViewController *viewController = [HttpTask theTopviewControler];
    [MBProgressHUD showHUDAddedTo:viewController.view animated:YES];
    
    if (needToken) {
        
        if ([remoteStr rangeOfString:@"?"].length == 0) {
            remoteStr=[NSString stringWithFormat:@"%@?token=%@&jsessionid=%@",remoteStr,token,jsessionid];
        } else  {
            remoteStr=[NSString stringWithFormat:@"%@&token=%@&jsessionid=%@",remoteStr,token,jsessionid];
        }
    }
    remoteStr = [remoteStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];//将汉字转码
    
    NSURL * remoteUrl = [NSURL URLWithString:remoteStr];
    NSLog(@"doGetToServer 请求远程地址为:%@",[remoteUrl absoluteString]);
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:remoteUrl];
    [request setRequestMethod:@"GET"];
    [request setShouldAttemptPersistentConnection:NO];
    //[request setTimeOutSeconds:TIMEOUT_SECONDS_GET];
    [request setCompletionBlock:^{
        NSString * responseStr = [request responseString];
        [MBProgressHUD hideHUDForView:viewController.view animated:YES];
        request = nil;
        if (sucessCallback) {
            sucessCallback(responseStr);
        }
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        [MBProgressHUD hideHUDForView:viewController.view animated:YES];
        request = nil;
        if (failCallback) {
            failCallback([error userInfo]);
        }
        if ([[[error userInfo]  objectForKey:@"NSLocalizedDescription"] isEqualToString:@"A connection failure occurred"]) {
            [[[UIAlertView alloc]initWithTitle:@"提示"
                                       message:@"网络连接失败，请检查网络！"
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil] show];
        }else{
            [[[UIAlertView alloc]initWithTitle:@"提示"
                                       message:@"网络连接超时！"
                                      delegate:nil
                             cancelButtonTitle:@"确定"
                             otherButtonTitles:nil] show];
            NSLog(@"HttpTask:doGetToServer:%@",[[error userInfo]  objectForKey:@"NSLocalizedDescription"]);
        }
        
    }];
    
    [request startAsynchronous];
    
}

+(void) doPostToServer:(NSString *) remoteStr
             needToken:(BOOL) needToken
                 param:(NSDictionary *)param
           sucessBlock:(void (^)(NSString *))sucessCallback
             failBlock:(void (^)(NSDictionary *))failCallback{
    
    remoteStr = [remoteStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL * remoteUrl = [NSURL URLWithString:remoteStr];
    
    __block ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:remoteUrl];
    [request setRequestMethod:@"POST"];
    for (NSString *key in [param allKeys]) {
        [request addPostValue:[param objectForKey:key] forKey:key];
    }
    
    [request setShouldAttemptPersistentConnection:NO];
    [request setCompletionBlock:^{
        NSString * responseStr = [request responseString];
        request = nil;
        if (sucessCallback) {
            sucessCallback(responseStr);
        }
    }];
    
    [request setFailedBlock:^{
        NSError *error = [request error];
        request = nil;
        if (failCallback) {
            failCallback([error userInfo]);
        }
        
    }];
    [request startAsynchronous];
}



#pragma mark ================= 登陆 =================
+(void) login:(NSDictionary *) param
  sucessBlock:(void (^)(NSString *))sucessCallback
    failBlock:(void (^)(NSDictionary *))failCallback
{
    NSString * remoteStr=[NSString stringWithFormat:@"%@/login",WD_BASE_URL];
    
    [self doPostToServer:remoteStr needToken:NO param:param sucessBlock:sucessCallback failBlock:failCallback];
}

#pragma mark ================= 库位管理接口 =================

#pragma mark ================= 获取仓库及下属库区信息 =================
+(void) getWarehouseRegion:(NSDictionary *) param
               sucessBlock:(void (^)(NSString *))sucessCallback
                 failBlock:(void (^)(NSDictionary *))failCallback
{
    NSString * remoteStr=[NSString stringWithFormat:@"%@/getWarehouseRegions",WD_BASE_URL];
    [self doPostToServer:remoteStr needToken:NO param:param sucessBlock:sucessCallback failBlock:failCallback];
}

#pragma mark ================= 获取库位信息 =================
+(void) getSlInfo:(NSDictionary *) param
      sucessBlock:(void (^)(NSString *))sucessCallback
        failBlock:(void (^)(NSDictionary *))failCallback
{
    NSString * remoteStr=[NSString stringWithFormat:@"%@/getSlInfos",WD_BASE_URL];
    [self doPostToServer:remoteStr needToken:NO param:param sucessBlock:sucessCallback failBlock:failCallback];
}

#pragma mark ================= 分页获取物流中心下货主 =================
+(void) getCustomer:(NSDictionary *) param
        sucessBlock:(void (^)(NSString *))sucessCallback
          failBlock:(void (^)(NSDictionary *))failCallback
{
    NSString * remoteStr=[NSString stringWithFormat:@"%@/getCustomersPage",WD_BASE_URL];
    [self doPostToServer:remoteStr needToken:NO param:param sucessBlock:sucessCallback failBlock:failCallback];
}
#pragma mark ================= 分页物料查询 =================
+(void) getMaterial:(NSDictionary *) param
        sucessBlock:(void (^)(NSString *))sucessCallback
          failBlock:(void (^)(NSDictionary *))failCallback
{
    NSString * remoteStr=[NSString stringWithFormat:@"%@/getMaterialPage",WD_BASE_URL];
    [self doPostToServer:remoteStr needToken:NO param:param sucessBlock:sucessCallback failBlock:failCallback];
}


+(UIViewController *)theTopviewControler{
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    UIViewController *parent = rootVC;
    
    while ((parent = rootVC.presentedViewController) != nil ) {
        rootVC = parent;
    }
    
    while ([rootVC isKindOfClass:[UINavigationController class]]) {
        rootVC = [(UINavigationController *)rootVC topViewController];
    }
    
    return rootVC;
}


@end
