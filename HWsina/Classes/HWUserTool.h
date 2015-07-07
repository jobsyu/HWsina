//
//  HWUserTool.h
//  HWsina
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseTool.h"
#import "HWUserInfoParam.h"
#import "HWUserInfoResult.h"
#import "HWUnreadCountParam.h"
#import "HWUnreadCountResult.h"

@interface HWUserTool : HWBaseTool

/**
 *  加载用户的个人信息
 *
 *  @param param 请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求成功后想做的事情写到这个block中）
 */
+ (void)userInfoWithParam:(HWUserInfoParam *)param success:(void (^)(HWUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  获取用户未读信息
 *
 *  @param param 请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求成功后想做的事情写到这个block中）
 */
+ (void)unreadCountWithParam:(HWUnreadCountParam *)param success:(void (^)(HWUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;
@end
