//
//  HWUserInfoParam.h
//  HWsina
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseParam.h"

@interface HWUserInfoParam : HWBaseParam
/** false	int64	需要查询的用户ID。*/
@property (nonatomic,copy) NSString *uid;
@end
