//
//  NSDate+Extension.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 * 判断某个时间是否为今年
 */
-(BOOL)isThisYear;
/**
 * 判断某个时间是否为昨天
 */
-(BOOL)isYesterday;
/**
 * 判断某个时间是否为今天
 */
-(BOOL)isToday;
@end
