//
//  HWBaseTextCellFrame.m
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseTextCellFrame.h"
#import "HWBaseText.h"
#import "HWUser.h"
#import "HWIconView.h"

@implementation HWBaseTextCellFrame

-(void)setBaseText:(HWBaseText *)baseText
{
    _baseText = baseText;
    
    HWUser *user = baseText.user;
    
    //cell的宽度
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    /* 头像 */
    CGFloat iconX = HWStatusCellBorderW;
    CGFloat iconY = HWStatusCellBorderW;
    CGSize  iconSize = [HWIconView iconSizeWithType:kIconTypeSmall];
    _iconViewF = CGRectMake(iconX, iconY, iconSize.width, iconSize.height);
    
    /** 昵称 */
    CGFloat nameX = CGRectGetMaxX(_iconViewF) + HWStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [user.name sizeWithFont:HWStatusCellNameFont];
    _nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** 会员图标 */
    if (user.verified) {
        CGFloat vipX = CGRectGetMaxX(_nameLabelF) +HWStatusCellBorderW;
        CGFloat vipY = nameY;
        CGFloat vipH = nameSize.height;
        CGFloat vipW = 14;
        _vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间 */
    CGFloat timeX =nameX;
    CGFloat timeY =CGRectGetMaxY(_nameLabelF) + HWStatusCellBorderW;
    CGSize timeSize = [baseText.createdAt sizeWithFont:HWStatusCellTimeFont];
    _timeLabelF = (CGRect){{timeX,timeY},timeSize};

    
    /** 微博／评论内容 */
    CGFloat contentX = nameX;
    CGFloat contentY = CGRectGetMaxY(_iconViewF) + HWStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX -iconSize.width;
    CGSize  contentSize = [baseText.text sizeWithFont:HWStatusCellContentFont maxW:maxW];
    _contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    /** cell的高度 **/
    _cellHeight = CGRectGetMaxY(_contentLabelF) + HWStatusCellBorderW;
}

@end
