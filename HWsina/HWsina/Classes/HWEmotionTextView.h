//
//  HWEmotionTextView.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWTextView.h"
@class HWEmotion;

@interface HWEmotionTextView : HWTextView
- (void)insertEmotion:(HWEmotion *)emotion;

- (NSString *)fullText;
@end
