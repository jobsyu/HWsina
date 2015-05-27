//
//  NewsHeaderView.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsHeaderView.h"
#import "UIImageView+WebCache.h"

@implementation NewsHeaderView{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UIView *_maskView;
}


-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self _initSubView];
    }
    return self;
}

-(void)_initSubView{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapViewAction:)];
    
    [self addGestureRecognizer:tapGes];
    
    _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];

    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-25, kSCREEN_WIDTH, 25)];
    _maskView.backgroundColor = Color(0, 0, 0, 0.5);
    [self addSubview:_maskView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bottom-25, kSCREEN_WIDTH, 25)];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textColor = [UIColor blackColor];
    //_titleLabel.textAlignment =NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self addSubview:_titleLabel];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_imageView setImageWithURL:[NSURL URLWithString:_newsModel.image]];
    _titleLabel.text = [NSString stringWithFormat:@" %@",_newsModel.title];
}

#pragma mark action
-(void)tapViewAction:(UITapGestureRecognizer *)ges{
    
    if([self.delegate respondsToSelector:@selector(tapNewsHeaderImageView:withID:)]){
        
        [self.delegate tapNewsHeaderImageView:self withID:_newsModel.id];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
