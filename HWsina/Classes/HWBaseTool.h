//
//  HWBaseTool.h
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  最基本的业务工具类

#import <Foundation/Foundation.h>

@interface HWBaseTool : NSObject
+(void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))
success failure:(void(^)(NSError *))failure;

+(void)getWithUrl:(NSString *)url param:(id)param success:(void (^)(id))
success failure:(void(^)(NSError *))failure;

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))
success failure:(void(^)(NSError *))failure;

+(void)postWithUrl:(NSString *)url param:(id)param images:(NSArray *)images resultClass:(Class)
resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
