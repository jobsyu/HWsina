//
//  HWBaseStatusCellFrame.h
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWStatus;

@interface HWBaseStatusCellFrame : NSObject
{
    CGFloat _cellHeight;
    CGRect _retweetViewF;
}

@property (nonatomic,strong) HWStatus *status;

/** cell的高度 */
@property (nonatomic,assign) CGFloat cellHeight;

/** 原创微博整体 */
@property (nonatomic,assign) CGRect originalViewF;
/** 头像 */
@property (nonatomic,assign) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic,assign) CGRect vipViewF;
/** 配图 */
@property (nonatomic,assign) CGRect photosViewF;
/** 昵称 */
@property (nonatomic,assign) CGRect nameLabelF;
/** 时间 */
@property (nonatomic,assign) CGRect timeLabelF;
/** 来源 */
@property (nonatomic,assign) CGRect sourceLabelF;
/** 正文 */
@property (nonatomic,assign) CGRect contentLabelF;

/** 转发微博整体 */
@property (nonatomic,assign) CGRect retweetViewF;

/** 转发微博正文 + 昵称 */
@property (nonatomic,assign) CGRect retweetContentLabelF;

/** 转发配图 */
@property (nonatomic,assign) CGRect retweetPhotosViewF;

/** 底部工具条 */
@property (nonatomic,assign) CGRect toolbarF;
@end
