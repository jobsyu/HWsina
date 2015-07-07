//
//  HWBaseText.m
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseText.h"
#import "HWUser.h"

@implementation HWBaseText

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.text = dict[@"text"];
        self.user = [[HWUser alloc] initWithDict:dict[@"user"]];
    }
    return self;
}

@end