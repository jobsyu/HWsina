//
//  HWStatusPhotosView.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  cell上面的配图相册（里面会显示1～9张图片，里面都是HWStatusPhotoView）

#import <UIKit/UIKit.h>

@interface HWStatusPhotosView : UIView
@property (nonatomic,strong) NSArray *photos;

/**
  * 根据图片个数计算相册的尺寸
  */
+ (CGSize)sizeWithCount:(NSUInteger)count;
@end
