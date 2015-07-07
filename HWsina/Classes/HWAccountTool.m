//
//  HWAccountTool.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  处理账号相关的所有操作:存储账号,取出账号，验证账号

//账号的存储路径
#define HWAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.archive"]

#import "HWAccountTool.h"
#import "HWAccount.h"

@implementation HWAccountTool

/**
  * 存储账号信息
  *
  * @param account 账号模型
  */
+ (void)saveAccount:(HWAccount *)account
{
    //自定义对象的存储必须用NSKeyedArchiver,不再有什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:account toFile:HWAccountPath];
}


/**
  * 返回账号信息
  *
  * @return 账号模型 (如果账号过期，返回nil)
  */
+(HWAccount *)account
{
   //加载模型
    HWAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:HWAccountPath];
    
    /*验证账号是否过期 */
    
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    //获得过期时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    //获得当前时间
    NSDate *now = [NSDate date];
    
    //如果expiresTime <= now 过期
    /**
      NSOrderedAscending = -1L,升序， 右边 > 左边
      NSOrderedSame, 一样
      NSOrderedDescending 降序， 右边 < 左边
     */
    NSComparisonResult result = [expiresTime compare:now];
    if (result != NSOrderedDescending) { //过期
        return nil;
    }
    
    return account;
}

+(void)accessTokenWithParam:(HWAccessTokenParam *)param success:(void (^)(HWAccount *))success failure:(void (^)(NSError *))failure
{
    /*
     URL：https://api.weibo.com/oauth2/access_token
     
     请求参数：
     client_id：申请应用时分配的AppKey
     client_secret：申请应用时分配的AppSecret
     grant_type：使用authorization_code
     redirect_uri：授权成功后的回调地址
     code：授权成功后返回的code
     */
    [self postWithUrl:@"https://api.weibo.com/oauth2/access_token" param:param resultClass:[HWAccount class] success:success failure:failure];
}
@end
