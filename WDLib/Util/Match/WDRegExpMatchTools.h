//
//  WDRegExpMatchTools.h
//  WDLib
//
//  Created by wandou on 19/12/2017.
//  Copyright © 2017 wandou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WDRegExpMatchTools : NSObject
//正则匹配手机号
+ (BOOL)checkTelNumber:(NSString *) telNumber;
//正则匹配用户邮箱
+ (BOOL)isValidateEmail:(NSString *) email;
//正则匹配用户密码6-18位数字和字母组合
+ (BOOL)checkPassword:(NSString *) password;
//正则匹配用户姓名,20位的中文或英文
+ (BOOL)checkUserName:(NSString *) userName;
//正则匹配用户身份证号
+ (BOOL)checkUserIdCard:(NSString *)idCard;
//正则匹配URL
+ (BOOL)checkURL:(NSString *) url;
@end
