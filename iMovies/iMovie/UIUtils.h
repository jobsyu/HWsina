//
//  UIUtils.h
//  iMovie
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIUtils : NSObject


//计算字体占据空间的大小
+(CGSize)sizeOfStr:(NSString *)str andFont:(UIFont *)font andMaxSize:(CGSize)size andLineBreakMode:(NSLineBreakMode)mode;

//视图切换 动画
+(void) animationWithButton:(UIView *)posterView listView:(UIView *)listView superView:(UIView *)superView;
+(void) animationWith: (UIView *)posterView listView:(UIView *)listView superView:(UIView *)superView;
@end
