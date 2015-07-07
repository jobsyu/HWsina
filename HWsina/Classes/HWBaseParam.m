//
//  HWBaseParam.m
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseParam.h"
#import "HWAccountTool.h"
#import "HWAccount.h"

@implementation HWBaseParam

-(instancetype)init{
    if (self = [super init]) {
        self.access_token = [HWAccountTool account].access_token;
    }
    return self;
}

+(instancetype)param
{
    return [[self alloc] init];
}
@end
