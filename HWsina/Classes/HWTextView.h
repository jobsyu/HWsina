//
//  HWTextView.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  增强： 带有占位文字

#import <UIKit/UIKit.h>

@interface HWTextView : UITextView
/** 占位文字 */
@property (nonatomic,copy) NSString *placeholder;
/** 占位文字的颜色 */
@property (nonatomic,strong) UIColor *placeholderColor;
@end
