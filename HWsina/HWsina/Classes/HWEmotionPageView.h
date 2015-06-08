//
//  HWEmotionPageView.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

// 一页中最多3行
#define HWEmotionMaxRows 3
// 一行中最多7列
#define HWEmotionMaxCols 7
// 每一页的表情个数
#define HWEmotionPageSize ((HWEmotionMaxRows * HWEmotionMaxCols) -1)


@interface HWEmotionPageView : UIView
/** 这一页显示的表情（里面都是HWEmotion模型）*/
@property (nonatomic,strong) NSArray *emotions;
@end
