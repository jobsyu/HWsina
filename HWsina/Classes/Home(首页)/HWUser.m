//
//  HWUser.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.name = dict[@"screen_name"];
        self.profile_image_url = dict[@"profile_image_url"];
        self.verified_type  = [dict[@"verified_type"] intValue];
        self.verified = [dict[@"verified"] boolValue];
        self.mbrank = [dict[@"mbrank"] intValue];
        self.mbtype = [dict[@"mbtype"] intValue];
    }
    return self;
}

-(void)setMbtype:(int)mbtype
{
    _mbtype =mbtype;
    self.verified = mbtype >= 2;
}

@end
