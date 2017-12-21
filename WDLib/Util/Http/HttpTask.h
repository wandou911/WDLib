//
//  HttpTask.h
//  WMS
//
//  Created by wandou on 2017/11/6.
//  Copyright © 2017年 wandou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpTask : NSObject

#pragma mark ================= 登陆 =================
+(void) login:(NSDictionary *) param
  sucessBlock:(void (^)(NSString *))sucessCallback
    failBlock:(void (^)(NSDictionary *))failCallback;


#pragma mark ================= 库位管理接口 =================

#pragma mark ================= 获取仓库及下属库区信息 =================
+(void) getWarehouseRegion:(NSDictionary *) param
  sucessBlock:(void (^)(NSString *))sucessCallback
    failBlock:(void (^)(NSDictionary *))failCallback;

#pragma mark ================= 获取库位信息 =================
+(void) getSlInfo:(NSDictionary *) param
  sucessBlock:(void (^)(NSString *))sucessCallback
    failBlock:(void (^)(NSDictionary *))failCallback;

#pragma mark ================= 分页获取物流中心下货主 =================
+(void) getCustomer:(NSDictionary *) param
  sucessBlock:(void (^)(NSString *))sucessCallback
    failBlock:(void (^)(NSDictionary *))failCallback;
#pragma mark ================= 分页物料查询 =================
+(void) getMaterial:(NSDictionary *) param
  sucessBlock:(void (^)(NSString *))sucessCallback
    failBlock:(void (^)(NSDictionary *))failCallback;



@end
