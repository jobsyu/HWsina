//
//  HWBaseTool.m
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseTool.h"
#import "MJExtension.h"
#import "HWHttpTool.h"
#import "HWStatus.h"

@implementation HWBaseTool

+ (void)getWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))
success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [HWHttpTool get:url parameters:params success:^(id reponseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:reponseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+ (void)getWithUrl:(NSString *)url param:(id)param  success:(void (^)(id))
    success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [HWHttpTool get:url parameters:params success:^(id reponseObject) {
        if (success) {
            NSMutableArray *statuses = [NSMutableArray array];
            
            //解析json对象
            NSArray *array = reponseObject[@"statuses"];
            for (NSDictionary *dict in array) {
                HWStatus *s = [[HWStatus alloc] initWithDict:dict];
                [statuses addObject:s];
            }
            
            //回调block
            //id result = [resultClass objectWithKeyValues:reponseObject];
            success(statuses);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)url param:(id)param resultClass:(Class)resultClass success:(void (^)(id))
   success failure:(void (^)(NSError *))failure
{
    NSDictionary *params =[param keyValues];
    [HWHttpTool post:url parameters:params success:^(id reponseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:reponseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)postWithUrl:(NSString *)url param:(id)param images:(NSArray *)images resultClass:(Class)resultClass success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    NSDictionary *params = [param keyValues];
    [HWHttpTool post:url parameters:params fileData:^(id<AFMultipartFormData> formData) {
        //目前新浪开放的发微博接口 最多只能上传一张图片
        UIImage *image = [images firstObject];
        
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        //拼接文件参数
        [formData appendPartWithFileData:data name:@"pic" fileName:@"status.jpg" mimeType:@"image/jpeg"];
    } success:^(id reponseObject) {
        if (success) {
            id result = [resultClass objectWithKeyValues:reponseObject];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
