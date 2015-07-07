//
//  HWStatusCell.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWStatusCell.h"
#import "HWStatusToolbar.h"
//#import "HWBaseStatusCellFrame.h"
#import "HWStatusCellFrame.h"


@interface HWStatusCell()
/** 工具条 */
@property (nonatomic,weak) HWStatusToolbar *toolbar;
@end

@implementation HWStatusCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupToolbar];
    }
    return self;
}



/**
 * 初始化工具条
 */
-(void)setupToolbar
{
    HWStatusToolbar *toolbar = [HWStatusToolbar toolbar];
    [self.contentView addSubview:toolbar];
    self.toolbar = toolbar;
}

-(void)setStatusCellFrame:(HWBaseStatusCellFrame *)statusCellFrame
{
    [super setStatusCellFrame:statusCellFrame];
    
    /** 工具条 */
    self.toolbar.frame =  statusCellFrame.toolbarF;
    self.toolbar.status = statusCellFrame.status;
}

@end

