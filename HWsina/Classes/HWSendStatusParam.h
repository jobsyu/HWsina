//
//  HWSendStatusParam.h
//  HWsina
//
//  Created by qianfeng on 15/6/17.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseParam.h"

@interface HWSendStatusParam : HWBaseParam

/**	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。*/
@property (nonatomic,copy) NSString *status;
@end
