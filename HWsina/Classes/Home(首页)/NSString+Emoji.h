//
//  NSString+Emoji.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Emoji)

/**
  * 将十六进制的编码转为emoji字符
  */
+(NSString *)emojiWithIntCode:(int)intCode;

/**
  * 将十六进制的编码转为emoji字符
  */
+ (NSString *)emojiWithStringCode:(NSString *)stringCode;
- (NSString *)emoji;

/**
  *  是否为emoji字符
  */
-(BOOL)isEmoji;
@end
