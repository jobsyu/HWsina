//
//  HWHomeStatusesParam.h
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  封装加载首页微博数据的请求

#import "HWBaseParam.h"

@interface HWHomeStatusesParam : HWBaseParam
/**	false	int64	若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。*/
@property (nonatomic,strong) NSNumber *since_id;

/** false	int64	若指定此参数，则返回ID小于或等于max_id的微博，默认为0。*/
@property (nonatomic,strong) NSNumber *max_id;

/** false	int	单页返回的记录条数，最大不超过100，默认为20。*/
@property (nonatomic,strong) NSNumber *count;
@end
