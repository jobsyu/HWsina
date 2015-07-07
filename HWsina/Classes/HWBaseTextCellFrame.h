//
//  HWBaseTextCellFrame.h
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HWBaseText;
@interface HWBaseTextCellFrame : NSObject

@property (nonatomic,strong) HWBaseText *baseText;
@property (nonatomic,readonly) CGFloat cellHeight;
@property (nonatomic,readonly) CGRect iconViewF; //头像
@property (nonatomic,readonly) CGRect nameLabelF; //昵称
@property (nonatomic,readonly) CGRect vipViewF; //会员图像
@property (nonatomic,readonly) CGRect timeLabelF;  //时间
@property (nonatomic,readonly) CGRect contentLabelF;  //内容
@end
