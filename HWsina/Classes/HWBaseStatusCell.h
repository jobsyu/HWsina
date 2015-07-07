//
//  HWBaseStatusCell.h
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseWordCell.h"
@class HWBaseStatusCellFrame;
@class HWStatus;

@interface HWBaseStatusCell : HWBaseWordCell
/** 转发微博整体 */
@property (nonatomic,weak) UIView *retweetView;
@property (nonatomic,strong) HWStatus *status;
@property (nonatomic,strong) HWBaseStatusCellFrame *statusCellFrame;
@end
