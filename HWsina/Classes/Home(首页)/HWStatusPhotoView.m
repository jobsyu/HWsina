//
//  HWStatusPhotoView.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  一张配图

#import "HWStatusPhotoView.h"
#import "HWPhoto.h"
#import "UIImageView+WebCache.h"

@interface HWStatusPhotoView()
@property (nonatomic,weak) UIImageView *gifView;
@end

@implementation HWStatusPhotoView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //内容模式
        self.contentMode = UIViewContentModeScaleAspectFill;
        //超出边框的内容都剪掉
        self.clipsToBounds = YES;
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width  - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

-(void)setUrl:(NSString *)url
{
    _url = url;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 显示\隐藏gif控件
    // 判断是以gif或者GIF结尾
    self.gifView.hidden = ![url.lowercaseString hasSuffix:@"gif"];
}

- (UIImageView *)gifView
{
    if (!_gifView) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView =[[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        self.gifView = gifView;
    }
    return _gifView;
}


@end
