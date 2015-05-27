//
//  CinemaModel.h
//  iMovie
//
//  Created by qianfeng on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface CinemaModel : BaseModel

__long(id);
__string(title);
__string(image);
__string(releaseDate);
__string(type);
__string(director);
__int(wantedCount);

@end


/**
 {
 "id" : 157836,
 "title" : "摩尔庄园2海妖宝藏",
 "image" : "http://img31.mtime.cn/mt/2012/06/28/131128.94272291.jpg",
 "releaseDate" : "7月5日上映",
 "type" : "动画/动作/奇幻/冒险",
 "director" : "刘可欣",
 "wantedCount" : 258
 },
 **/