//
//  HWStatusFrame.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWStatusCellFrame.h"
#import "HWStatus.h"

@implementation HWStatusCellFrame

-(void)setStatus:(HWStatus *)status
{
    [super setStatus:status];
    
    /** 工具条 */
    CGFloat toolbarX = 0;
    CGFloat toolbarW = [UIScreen mainScreen].bounds.size.width;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, self.cellHeight, toolbarW, toolbarH);
    /* cell的高度 */
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}

@end