//
//  HWRetweetedToolbar.h
//  HWsina
//
//  Created by qianfeng on 15/6/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatus;

@interface HWRetweetedToolbar : UIView
+ (instancetype)toolbar;
@property (nonatomic,strong) HWStatus *status;
@end
