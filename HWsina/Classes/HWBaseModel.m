//
//  BaseModel.m
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseModel.h"

@implementation HWBaseModel

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.ID = [dict[@"id"] longLongValue];
        self.createdAt = dict[@"created_at"];
    }
    return self;
}

-(NSString *)createdAt{
    /**
     1.今年
     1> 今天
     * 1分内：刚刚
     * 1分～59分内：xx分钟前
     * 大于60分钟：xx小时前
     
     2> 昨天
     * 昨天 xx:xx
     
     3> 其他
     * xx-xx xx:xx
     2.非今年
     1> xxxx-xx-xx xx:xx
     */
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //若在中文语言环境是无法解析英语格式的日期：需要设置解析的语言环境
    //如果是真机调试，转换这种欧美时间，需要设置locale
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    
    // 设置日期格式 (声明字符串里面每个数字和单词的含义)
    // E:星期几
    // M:月份
    // d:几号(这个月的第几天)
    // H:24小时制的小时
    // m:分钟
    // s:秒
    // y:年
    fmt.dateFormat= @"EEE MMM dd HH:mm:ss Z yyyy";
    //_created_at = @"Tue Sep 30 17:06:25 +0600 2014";
    
    //微博的创建日期
    NSDate *createDate = [fmt dateFromString:_createdAt];
    //当前时间
    NSDate *now = [NSDate date];
    
    //日历对象 (方便比较两个日期之间的差距)
    NSCalendar *calendar =[NSCalendar currentCalendar];
    
    // NSCalendarUnit枚举代表想获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay| NSCalendarUnitHour |
    NSCalendarUnitMinute | NSCalendarUnitSecond;
    
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    if ([createDate isThisYear]) { //今年
        if([createDate isYesterday]){ //昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else if ([createDate isToday]) { //今天
            if(cmps.hour >= 1){
                return [NSString stringWithFormat:@"%d小时前",(int)cmps.hour];
            } else if(cmps.minute >=1){
                return [NSString stringWithFormat:@"%d分钟前",(int)cmps.minute];
            } else {
                return @"刚刚";
            }
        }else { //今年的其他日子
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { //非今年
        fmt.dateFormat =@"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

@end
