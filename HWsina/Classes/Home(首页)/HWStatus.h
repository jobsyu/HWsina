//
//  HWStatus.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  微博模型

#import "HWBaseText.h"
@class HWUser;

@interface HWStatus : HWBaseText
/** string 微博来源*/
@property (nonatomic,copy) NSString *source;

/** 微博配图地址。 多图时返回多图链接。无配图返回“[]” */
@property (nonatomic,strong) NSArray *pic_urls;

/** 被转发的原微博信息字段，当该微博为转发微博时返回 */
@property (nonatomic,strong) HWStatus *retweeted_status;

/** int 转发数 */
@property (nonatomic,assign) int reposts_count;
/** int 评论数 */
@property (nonatomic,assign) int comments_count;
/** int 表态数 */
@property (nonatomic,assign) int attitudes_count;
@end
