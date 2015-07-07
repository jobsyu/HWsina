//
//  HWHomeStatusesResult.m
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWHomeStatusesResult.h"
#import "HWStatus.h"
#import "MJExtension.h"

@implementation HWHomeStatusesResult
-(NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [HWStatus class]};
    //return @{@"users"}
}
@end
