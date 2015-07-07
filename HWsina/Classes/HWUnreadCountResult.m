//
//  HWUnreadCountResult.m
//  HWsina
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWUnreadCountResult.h"

@implementation HWUnreadCountResult

-(int)messageCount
{
    return self.cmt + self.dm + self.mention_cmt + self.mention_status;
}

-(int)totalCount
{
    return self.messageCount + self.status +self.follower;
}
@end
