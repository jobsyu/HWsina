//
//  USAModel.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface USAModel : BaseModel

__string(alt);
__string(id);
__sysclass(NSDictionary, images);
__string(original_title);
__sysclass(NSDictionary, rating);
__string(subtype);
__string(title);
__string(year);

@end


/**
 
 "subject" : {
 "alt" : "http://movie.douban.com/subject/3895511/",
 "id" : "3895511",
 "images" : {
 "large" : "http://img3.douban.com/view/movie_poster_cover/lpst/public/p1931650344.jpg",
 "medium" : "http://img3.douban.com/view/movie_poster_cover/spst/public/p1931650344.jpg",
 "small" : "http://img3.douban.com/view/photo/icon/public/p1931650344.jpg"
 },
 "original_title" : "Oblivion",
 "rating" : {
 "average" : 6.7,
 "max" : 10,
 "min" : 0,
 "stars" : "35"
 },
 "subtype" : "movie",
 "title" : "遗落战境",
 "year" : "2013"
 }
 
 
 
 **/