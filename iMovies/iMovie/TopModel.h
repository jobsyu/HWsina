//
//  TopModel.h
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface TopModel : BaseModel

__float(rating);
__string(pubdate);
__string(title);
__sysclass(NSDictionary, images);
__string(id);
__long(collection);

@end


/***
 
 "entries": [
 {
 "rating": 8,
 "pubdate": "2013-03-21",
 "title": "北京遇上西雅图",
 "images": {
 "large": "http://img3.douban.com/view/photo/photo/public/p1910895969.jpg",
 "small": "http://img3.douban.com/view/photo/photo/public/p1910895969.jpg",
 "medium": "http://img3.douban.com/view/photo/thumb/public/p1910895969.jpg"
 },
 "id": "10574468",
 "collection": 59681
 },
 
 ***/