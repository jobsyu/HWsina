//
//  HWUser.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWUser.h"

@implementation HWUser
-(void)setMbtype:(int)mbtype
{
    _mbtype =mbtype;
    self.vip = mbtype > 2;
}

@end
