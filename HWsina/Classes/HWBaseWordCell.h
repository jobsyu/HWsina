//
//  BaseWordCell.h
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseCell.h"
@class HWIconView;
@interface HWBaseWordCell : HWBaseCell
{
    /** 原创微博整体 */
    UIView *_originalView;
    /** 头像 */
    HWIconView *_iconView;
    /** 会员图标 */
    UIImageView *_vipView;
    /** 昵称 */
    UILabel *_nameLabel;
    /** 时间 */
    UILabel *_timeLabel;
    /** 正文 */
    UILabel *_contentLabel;
}

@end
