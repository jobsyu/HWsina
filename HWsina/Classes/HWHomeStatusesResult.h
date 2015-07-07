//
//  HWHomeStatusesResult.h
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  封装加载首页微博数据的返回结果

#import <Foundation/Foundation.h>

@interface HWHomeStatusesResult : NSObject
/** 微博数组（装着HWStatus模型）*/
@property (nonatomic,strong) NSArray *statuses;

/** 近期的微博总数 */
@property (nonatomic,assign) int total_number;
@end
