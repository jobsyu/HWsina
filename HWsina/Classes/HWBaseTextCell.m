//
//  HWBaseTextCell.m
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseTextCell.h"
#import "HWBaseTextCellFrame.h"
#import "HWIconView.h"
#import "HWBaseText.h"
#import "HWUser.h"

@implementation HWBaseTextCell

-(void)setCellFrame:(HWBaseTextCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    HWBaseText *baseText  = cellFrame.baseText;
    HWUser *user = baseText.user;
    
    /** 头像 **/
    _iconView.frame = cellFrame.iconViewF;
    _iconView.user = user;
    
    /** 昵称 **/
    _nameLabel.frame = cellFrame.nameLabelF;
    _nameLabel.text = baseText.text;
    
    /** 会员图标 */
    if (user.verified) {
        _nameLabel.textColor = kMBScreenNameColor;
        _vipView.hidden =NO;
        _vipView.frame = cellFrame.vipViewF;
        //NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        
    } else {
        _nameLabel.textColor = kScreenNameColor;
        _vipView.hidden = YES;
    }

    /** 时间 **/
    _timeLabel.frame = cellFrame.timeLabelF;
    _timeLabel.text = baseText.createdAt;
    
    /** 转发评论内容 **/
    _contentLabel.frame = cellFrame.contentLabelF;
    _contentLabel.text = baseText.text;
}

@end
