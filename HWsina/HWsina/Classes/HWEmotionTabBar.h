//
//  HWEmotionTabBar.h
//  HWsina
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    HWEmotionTabBarButtonTypeRecent, //最近
    HWEmotionTabBarButtonTypeDefault, //默认
    HWEmotionTabBarButtonTypeEmoji,  //emoji
    HWEmotionTabBarButtonTypeLxh,  //浪小花
} HWEmotionTabBarButtonType;

@class HWEmotionTabBar;

@protocol HWEmotionTabBarDelegate <NSObject>

@optional
-(void)emotionTabBar:(HWEmotionTabBar *)tabBar didSelectButton:(HWEmotionTabBarButtonType)buttonType;

@end

@interface HWEmotionTabBar : UIView
@property (nonatomic,weak) id<HWEmotionTabBarDelegate> delegate;
@end
