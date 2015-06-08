//
//  HWLoadMoreFooter.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWLoadMoreFooter.h"

@implementation HWLoadMoreFooter
+ (instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWLoadMoreFooter" owner:nil options:nil] lastObject];
}
@end
