//
//  HWEmotionAttachment.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWEmotionAttachment.h"
#import "HWEmotion.h"
@implementation HWEmotionAttachment
-(void)setEmotion:(HWEmotion *)emotion
{
    _emotion = emotion;
    
    self.image = [UIImage imageNamed:emotion.png];
}
@end
