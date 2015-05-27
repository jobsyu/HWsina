//
//  PhotoRecord.h
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PhotoRecord : NSObject

@property (nonatomic,strong) NSString * name; //to store the name of image
@property (nonatomic,strong) UIImage  *image; //to store actual the image
@property (nonatomic,strong) NSURL *URL; //to store the URL of the image

@property (nonatomic,readonly) BOOL hasImage; // return YES if the image is downloaded
@property (nonatomic,getter = isFiltered) BOOL filtered; // return YES if the image is sepia_Filered
@property (nonatomic,getter = isFailed) BOOL failed; // return YES  if the image  failed to be downloaded

@end
