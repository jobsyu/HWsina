//
//  AlbumView.h
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AlbumViewDelegate <NSObject>

-(void)didAlbumView;

@end

@interface AlbumView : UIView<UIScrollViewDelegate>

__string(imgUrl);
__uiclass(UIScrollView, scrollview);
__uiclass(UIImageView, imageView);
__delegate(AlbumViewDelegate, delegate);

@end
