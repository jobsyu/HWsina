//
//  HWEmotionKeyboard.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  表情键盘顶部的内容:scrollView + pageControl

#import <UIKit/UIKit.h>

@interface HWEmotionKeyboard : UIView
/** 表情（里面存放的HWEmotion模型）*/
@property (nonatomic,strong) NSArray *emotions;
@end
