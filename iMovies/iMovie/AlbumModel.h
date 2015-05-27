//
//  AlbumModel.h
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface AlbumModel : BaseModel

__string(title);
__string(desc);
__string(url1);
__string(url2);

@end


/*
 
 {
 "title": "宋佳长裙清新粉嫩",
 "desc": "最佳女配角奖",
 "url1": "http://img31.mtime.cn/CMS/Gallery/2012/12/17/100615.53731295.jpg",
 "url2": "http://img31.mtime.cn/CMS/Gallery/2012/12/17/100615.53731295_900.jpg"
 }
 
 */