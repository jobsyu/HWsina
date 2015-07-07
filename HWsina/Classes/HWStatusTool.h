//
//  HWStatusTool.h
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseTool.h"
#import "HWHomeStatusesParam.h"
#import "HWSendStatusParam.h"
#import "HWSendStatusResult.h"
#import "HWHomeStatusesResult.h"

@interface HWStatusTool : HWBaseTool

/**
 *  加载首页的微博数据
 *
 *  @param param  请求参数
 *  @param success  请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure  请求失败后的回调（请将请求成功后想做的事情写到这个block中）
 */
+ (void)homeStatusesWithParam:(HWHomeStatusesParam *)param success:(void (^)(NSArray *result
    ))success failure:(void (^)(NSError *error))failure;

/**
 * 发没有图片的微博
 *
 * @param param   请求参数
 * @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 * @param failure 请求失败后的回调（请将请求成功后想做的事情写到这个block中）
 */
+(void)sendStatusWithParam:(HWSendStatusParam *)param success:(void (^)(HWSendStatusResult *result
   ))success failure:(void (^)(NSError *error))failure;

/**
 * 发有图片的微博
 *
 * @param param   请求参数
 * @param images  图片数组
 * @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 * @param failure 请求失败后的回调（请将请求成功后想做的事情写到这个block中）
 */
+(void)sendStatusWithParam:(HWSendStatusParam *)param images:(NSArray *)images success:(void (^)
    (HWSendStatusResult *result))success failure:(void (^)(NSError *error))failure;
@end
