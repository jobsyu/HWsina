//
//  HWEmotionTool.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWEmotion;

@interface HWEmotionTool : NSObject
+ (void)addRecentEmotion:(HWEmotion *)emotion;
+ (NSArray *)recentEmotions;
@end
