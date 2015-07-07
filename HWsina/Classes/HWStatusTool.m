//
//  HWStatusTool.m
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWStatusTool.h"
#import "HWHttpTool.h"
#import "MJExtension.h"

@implementation HWStatusTool


+(void)homeStatusesWithParam:(HWHomeStatusesParam *)param success:(void (^)(NSArray *))
    success failure:(void (^)(NSError *))failure
{
    [self getWithUrl:@"https://api.weibo.com/2/statuses/friends_timeline.json" param:param success:success failure:failure];
}


/**
 *  发送微博业务处理类
 *
 *  @param param   微博模型参数
 *  @param success 成功回调的block
 *  @param failure 失败回调的block
 */

// URL: https://api.weibo.com/2/statuses/update.json
// 参数:
/**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
/**	access_token true string*/
+(void)sendStatusWithParam:(HWSendStatusParam *)param success:(void (^)(HWSendStatusResult *))success
    failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://api.weibo.com/2/statuses/update.json" param:param resultClass:
        [HWSendStatusResult class] success:success failure:failure];
}

// URL: https://upload.api.weibo.com/2/statuses/upload.json
// 参数:
/**	status true string 要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
/**	access_token true string*/
/**	pic true binary 微博的配图。*/
+(void)sendStatusWithParam:(HWSendStatusParam *)param images:(NSArray *)images success:(void (^)
    (HWSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [self postWithUrl:@"https://upload.api.weibo.com/2/statuses/upload.json" param:param images:images
        resultClass:[HWSendStatusResult class] success:success failure:failure];
}
@end
