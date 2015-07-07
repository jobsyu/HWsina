//
//  HWTabBar.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWTabBar;

#warning 因为HWTabBar继承自UITabBar,所以称为HWTabBar的代理，也必须实现UITabBar的代理协议
@protocol HWTabBarDelegate <UITabBarDelegate>
-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar;
@end
@interface HWTabBar : UITabBar
@property (nonatomic,weak) id<HWTabBarDelegate> delegate;
@end
