//
//  HWUserTool.m
//  HWsina
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWUserTool.h"
#import "MJExtension.h"
#import "HWHttpTool.h"

@implementation HWUserTool

+ (void)userInfoWithParam:(HWUserInfoParam *)param success:(void (^)(HWUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/users/show.json" param:param resultClass:[HWUserInfoResult class] success:success failure:failure];
}

+ (void)unreadCountWithParam:(HWUnreadCountParam *)param success:(void (^)(HWUnreadCountResult *))success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://rm.api.weibo.com/2/remind/unread_count.json" param:param resultClass:[HWUnreadCountResult class] success:success failure:failure];
}
@end
