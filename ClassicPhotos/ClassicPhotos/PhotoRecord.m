//
//  PhotoRecord.m
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PhotoRecord.h"

@implementation PhotoRecord

@synthesize name =_name;
@synthesize image = _image;
@synthesize URL = _URL;

@synthesize hasImage =_hasImage;
@synthesize filtered = _filtered;
@synthesize failed = _failed;


-(BOOL)hasImage{
    return _image !=nil;
}

-(BOOL)isFailed{
    return _failed;
}


-(BOOL)isFiltered{
    return _filtered;
}

@end
