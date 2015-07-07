//
//  HWStatusDetailFrame.m
//  HWsina
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWStatusDetailCellFrame.h"
#import "HWStatus.h"

@implementation HWStatusDetailCellFrame
-(void)setStatus:(HWStatus *)status
{
    [super setStatus:status];
    
    if (status.retweeted_status) {
        //self.retweetViewF.size.height += 80;
        //self.retweetViewF.size.height += 80;
        self.cellHeight += 80;
    }
}

@end
