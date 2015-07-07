//
//  HWBaseText.h
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWBaseModel.h"
@class HWUser;
@interface HWBaseText : HWBaseModel
/** string 微博信息内容 */
@property (nonatomic,copy) NSString *text;
/** object 微博作者的用户信息字段 详细 */
@property (nonatomic,strong) HWUser *user;
@end
