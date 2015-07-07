//
//  HWBaseStatusCell.m
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseStatusCell.h"
#import "HWStatusPhotosView.h"
#import "HWIconView.h"
#import "HWUser.h"
#import "HWStatus.h"
#import "HWBaseStatusCellFrame.h"

@interface HWBaseStatusCell()
/* 原创微博 */
/** 配图 */
@property (nonatomic,weak) HWStatusPhotosView *photosView;
/** 来源 */
@property (nonatomic,weak) UILabel *sourceLabel;


/** 转发微博 */
/** 转发微博正文 + 昵称 */
@property (nonatomic,weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic,weak) HWStatusPhotosView *retweetPhotosView;
@end

@implementation HWBaseStatusCell

/**
 * cell的初始化方法，一个cell只会调用一次
 * 一般在这里添加所有可能显示的子控件，以及子控件的一次性设置
 */
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.backgroundColor = [UIColor clearColor];
        //点击cell的时候不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        // 初始化原创微博
        [self setupOriginal];
        
        // 初始化转发微博
        [self setupRetweet];
        
        // 初始化工具条
        //[self setupToolbar];
    }
    return self;
}

/**
 * 初始化转发微博
 */
-(void)setupRetweet
{
    /** 转发微博整体 */
    UIView *retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = HWColor(247, 247, 247);
    [self.contentView addSubview:retweetView];
    self.retweetView = retweetView;
    
    /** 转发微博正文 + 昵称 */
    UILabel *retweetContentLabel = [[UILabel alloc] init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = HWStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    self.retweetContentLabel  = retweetContentLabel;
    
    /** 转发微博配图 */
    HWStatusPhotosView *retweetPhotosView = [[HWStatusPhotosView alloc] init];
    [retweetView addSubview:retweetPhotosView];
    self.retweetPhotosView = retweetPhotosView;
}


/**
 * 初始化原创微博
 */
-(void)setupOriginal
{
    /** 配图 */
    HWStatusPhotosView *photosView = [[HWStatusPhotosView alloc] init];
    [_originalView addSubview:photosView];
    self.photosView = photosView;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc] init];
    sourceLabel.font = HWStatusCellSourceFont;
    sourceLabel.textColor = [UIColor grayColor];
    [_originalView addSubview:sourceLabel];
    self.sourceLabel = sourceLabel;
}


-(void)setStatusCellFrame:(HWBaseStatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    
    _status = statusCellFrame.status;
    HWUser *user = _status.user;
    
    /** 原创微博整体 */
    _originalView.frame = statusCellFrame.originalViewF;
    
    /** 头像 */
    _iconView.frame = statusCellFrame.iconViewF;
    _iconView.user = user;
    
    /** 会员图标 */
    if (user.verified) {
        _vipView.hidden =NO;
        _vipView.frame = statusCellFrame.vipViewF;
        //NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        _nameLabel.textColor = kMBScreenNameColor;
    } else {
        _nameLabel.textColor = kScreenNameColor;
        _vipView.hidden = YES;
    }
    
    /* 配图 */
    if (_status.pic_urls.count) {
        self.photosView.frame = statusCellFrame.photosViewF;
        self.photosView.photos = _status.pic_urls;
        self.photosView.hidden = NO;
    } else {
        self.photosView.hidden = YES;
    }
    
    /** 昵称 */
    _nameLabel.text = user.name;
    _nameLabel.frame= statusCellFrame.nameLabelF;
    
    /** 时间 */
    CGFloat timeX = statusCellFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusCellFrame.nameLabelF) + HWStatusCellBorderW;
    CGSize  timeSize = [_status.createdAt sizeWithFont:HWStatusCellTimeFont];
    _timeLabel.frame = (CGRect){{timeX,timeY},timeSize};
    _timeLabel.text = _status.createdAt;
    
    /** 来源 */
    CGFloat sourceX = CGRectGetMaxX(_timeLabel.frame) + HWStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [_status.source sizeWithFont:HWStatusCellSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};
    self.sourceLabel.text = _status.source;
    
    /** 正文 */
    _contentLabel.text = _status.text;
    _contentLabel.frame =statusCellFrame.contentLabelF;
    
    /** 被转发的微博 */
    if (_status.retweeted_status) {
        HWStatus *retweeted_status = _status.retweeted_status;
        HWUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        /** 被转发的微博整体 */
        self.retweetView.frame = statusCellFrame.retweetViewF;
        
        /** 被转发的微博正文 */
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusCellFrame.retweetContentLabelF;
        
        /** 被转发的微博配图 */
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotosView.frame = statusCellFrame.retweetPhotosViewF;
            self.retweetPhotosView.photos = retweeted_status.pic_urls;
            self.retweetPhotosView.hidden = NO;
        } else {
            self.retweetPhotosView.hidden = YES;
        }
    } else {
        self.retweetView.hidden = YES;
    }
    
   
}


@end
