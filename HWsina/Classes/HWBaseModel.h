//
//  BaseModel.h
//  HWsina
//
//  Created by 於程鹏 on 15/6/20.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWBaseModel : NSObject
/** string 微博创建ID*/
@property (nonatomic,assign) long long ID;
/** string 微博创建时间*/
@property (nonatomic,copy) NSString *createdAt;

-(id)initWithDict:(NSDictionary *)dict;
@end
