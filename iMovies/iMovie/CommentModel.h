//
//  CommentModel.h
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseModel.h"

@interface CommentModel : BaseModel

__string(userImage);
__string(nickname);
__string(rating);
__string(content);

@end

/*
 
 "list" : [
 {
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 },
 
 
 
 */