//
//  HWEmotionPopView.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWEmotion,HWEmotionButton;

@interface HWEmotionPopView : UIView
+ (instancetype)popView;

-(void)showFrom:(HWEmotionButton *)button;
@end
