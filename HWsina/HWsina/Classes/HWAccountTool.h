//
//  HWAccountTool.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  处理账号相关的所有操作:存储账号,取出账号，验证账号

#import <Foundation/Foundation.h>
#import "HWAccount.h"

@interface HWAccountTool : NSObject
/**
  * 存储账号信息
  *
  * @param account 账号模型
  */
+(void)saveAccount:(HWAccount *)account;

/**
 * 返回账号信息
 *
 * @return 账号模型 (如果账号过期，返回nil)
 */
+ (HWAccount *)account;
@end
