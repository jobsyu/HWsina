//
//  HWStatusToolbar.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatus;

@interface HWStatusToolbar : UIView
+ (instancetype)toolbar;
@property (nonatomic,strong) HWStatus *status;
@end
