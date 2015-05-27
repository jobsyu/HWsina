//
//  AlbumView.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AlbumView.h"
#import "SDWebImage/UIImageView+WebCache.h"

@implementation AlbumView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self =[super initWithFrame:frame];
    if (self) {
        [self _initView];
    }
    return self;
}


-(void)_initView{
   _scrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _scrollview.minimumZoomScale = 1;
    _scrollview.maximumZoomScale = 2.5;
    _scrollview.showsVerticalScrollIndicator = NO;
    _scrollview.showsHorizontalScrollIndicator = NO;
    _scrollview.delegate =self;
    _scrollview.scrollsToTop = NO;
    [self addSubview:_scrollview];
    
    _imageView = [[UIImageView alloc] initWithFrame:_scrollview.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    _imageView.userInteractionEnabled = YES;
    [_scrollview addSubview:_imageView];
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [_imageView addGestureRecognizer:tapGes];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapAction:)];
    [doubleTap setNumberOfTapsRequired:2];
    [_imageView addGestureRecognizer:doubleTap];
    
    //双击时 忽略点击事件
    [tapGes requireGestureRecognizerToFail:doubleTap];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [_imageView setImageWithURL:[NSURL URLWithString:_imgUrl]];
}


#pragma mark UIScrollView delegate
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

#pragma mark actions
-(void)tapAction:(UITapGestureRecognizer *)ges{
    if([self.delegate respondsToSelector:@selector(didAlbumView)]){
        [self.delegate didAlbumView];
    }
}

-(void)doubleTapAction:(UITapGestureRecognizer *)ges{
    CGPoint point = [ges locationInView:_imageView];
    if(_scrollview.zoomScale == 1){
       [_scrollview zoomToRect:CGRectMake(point.x-40, point.y-40, 80, 80) animated:YES];
    }else {
       [_scrollview setZoomScale:1 animated:YES];
    }
}
@end
