//
//  NewsModel.h
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

__long(id);
__int(type);
__string(title);
__string(summary);
__string(image);

@end

/***
 
 
 {
 "id" : 1491520,
 "type" : 0,
 "title" : "科幻大作《全面回忆》全新预告片发布",
 "summary" : "",
 "image" : "http://img31.mtime.cn/mg/2012/06/28/100820.21812355.jpg"
 }
 
 ***/