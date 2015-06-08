//
//  HWStatusCell.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatusFrame;

@interface HWStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic,strong) HWStatusFrame *statusFrame;
@end
