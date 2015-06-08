//
//  NSDate+Extension.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


/**
 * 判断某个时间是否为今年
 */
-(BOOL)isThisYear
{
    NSCalendar *calendar =[[NSCalendar alloc] init];
    //获得某个时间的年月日时分秒
    NSDateComponents *dateCmps =[calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year = nowCmps.year;
}
/**
 * 判断某个时间是否为昨天
 */
-(BOOL)isYesterday
{
    NSDate *now = [NSDate date];
    
    //date == 2014-04-30 10:05:28 --> 2014-04-30 00:00:00
    //now == 2014-05-01 09:22:10 --> 2014-05-01 00:00:00
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    // 2014-04-30
    NSString *dateStr = [fmt stringFromDate:self];
    // 2015-06-02
    NSString *nowStr = [fmt stringFromDate:now];
    
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    NSCalendar *canlendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth |NSCalendarUnitDay;
    NSDateComponents *cmps = [canlendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}
/**
 * 判断某个时间是否为今天
 */
-(BOOL)isToday{
  
    NSDate *now =[NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    return [dateStr isEqualToString:nowStr];
}
@end
