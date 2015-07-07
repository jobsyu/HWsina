//
//  BaseWordCell.m
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseWordCell.h"
#import "HWIconView.h"

@interface HWBaseWordCell()

@end

@implementation HWBaseWordCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addMySubViews];
    }
    return self;
}

-(void)addMySubViews
{
    /** 原创微博整体 */
    _originalView =[[UIView alloc] init];
    _originalView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_originalView];
    
    /** 头像 */
    _iconView = [[HWIconView alloc] init];
    _iconView.type = kIconTypeSmall;
    [_originalView addSubview:_iconView];
    
    /** 会员图标 */
    _vipView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_membership.png"]];
    _vipView.contentMode = UIViewContentModeCenter;
    [_originalView addSubview:_vipView];
    
    /** 昵称 */
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = HWStatusCellNameFont;
    [_originalView addSubview:_nameLabel];
    
    /** 时间 */
    _timeLabel = [[UILabel alloc] init];
    _timeLabel.font = HWStatusCellTimeFont;
    _timeLabel.textColor = [UIColor orangeColor];
    [_originalView addSubview:_timeLabel];

    /** 正文 */
    _contentLabel = [[UILabel alloc] init];
    _contentLabel.font = HWStatusCellContentFont;
    _contentLabel.numberOfLines = 0;
    [_originalView addSubview:_contentLabel];
}


@end
