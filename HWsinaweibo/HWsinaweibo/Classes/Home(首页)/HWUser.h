//
//  HWUser.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

typedef enum {
    HWUSerVerifiedTypeNone = -1, //没有任何认证
    HWUSerVerifiedPersonal = 0,  //个人认证
    HWUSerVerifiedOrgEnterprice = 2, //企业官方：CSDN，EOE，搜狐新闻客户端
    HWUSerVerifiedOrgMedia = 3, //媒体官方：程序员杂志，苹果汇
    HWUSerVerifiedOrgWebsite = 5, //网站官方：猫扑
    HWUSerVerifiedDaren = 220 // 微博达人
} HWUSerVerifiedType;

@interface HWUser : NSObject
/** string 字符串型的用户UID */
@property (nonatomic,copy) NSString *idstr;

/** string 友好显示名称*/
@property (nonatomic,copy) NSString *name;

/** string 用户图像地址，50*50像素*/
@property (nonatomic,copy) NSString *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic,assign) int mbtype;
/** 会员等级 */
@property (nonatomic,assign) int mbrank;
@property (nonatomic,assign,getter = isVip) BOOL vip;

/** 认证类型 */
@property (nonatomic,assign) HWUSerVerifiedType verified_type;
@end
