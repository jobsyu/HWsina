//
//  HWHttpTool.m
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWHttpTool.h"
#import "AFNetworkActivityIndicatorManager.h"
#import "UIImageView+WebCache.h"

@implementation HWHttpTool

+(void)get:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:
    (void (^)(NSError *))failure
{
    // 1.获取请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送GET请求
    [mgr GET:url parameters:parameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         if (success) {
             success(responseObject);
         }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url parameters:(NSDictionary *)parameters success:(void (^)(id))success failure:
    (void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:url parameters:parameters
      success:^(AFHTTPRequestOperation *operation, id responseObject) {
          if (success) {
              success(responseObject);
          }
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          if (failure) {
              failure(error);
          }
      }];
}

+(void)post:(NSString *)url parameters:(NSDictionary *)parameters fileData:(void (^)(id<
   AFMultipartFormData>))fileData success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.发送POST请求
    [mgr POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        fileData(formData);
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)monitoringReachabilityStatus:(void (^)(AFNetworkReachabilityStatus))statusBlock
{
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    //当网络状态改变了，就会调用
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status) {
            statusBlock(status);
        }
    }];
    // 开始监控
    [mgr startMonitoring];
}

+(void)showNetworkActivityIndicator
{
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
}

+ (void)downloadImage:(NSString *)url place:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
 
}

@end
