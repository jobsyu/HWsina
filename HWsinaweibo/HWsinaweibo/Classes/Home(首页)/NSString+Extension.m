//
//  NSString+Extension.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)
-(CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs =[NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    CGSize maxSize = CGSizeMake(maxW, MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

-(CGSize)sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}
@end
