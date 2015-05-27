//
//  TopView.m
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopView.h"
#import "StarView.h"
#import "UIImageView+WebCache.h"

@implementation TopView{
    UIImageView *_mImageView;
    UILabel *_titleLabel;
    StarView *_starView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [self addGestureRecognizer:tapGes];
        [self _initSubView];
    }
    return self;
}


#pragma mark init subView 100

-(void) _initSubView{
    
    _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, self.width-40, 80)];
    _mImageView.layer.cornerRadius = 1;
    _mImageView.layer.masksToBounds = YES;
    _mImageView.layer.shadowPath = [[UIBezierPath bezierPathWithRect:CGRectMake(20, 0, self.width-40, 80)] CGPath];
    [self addSubview:_mImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, _mImageView.bottom, self.width-20, 20)];
    _titleLabel.backgroundColor = [UIColor blackColor];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment  = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:_titleLabel];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(15, _titleLabel.bottom, self.width-10, 20)];
    _starView.style = kSmallStyle;    [self addSubview:_starView];
    
}

-(void) setTopModel:(TopModel *)topModel{
    
    if (_topModel != topModel) {
        _topModel = topModel;
        /*************************************数据加载***************************************/
        NSString *imageUrl = [_topModel.images objectForKey:@"small"];
        [_mImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:kMOVIE_DEFUALT_BG]];
        _titleLabel.text = _topModel.title;
        _starView.rating = _topModel.rating;
        
    }
    
}

#pragma mark action
-(void)tapAction{
    
    if ([self.delegate respondsToSelector:@selector(tapTopView:withID:)]) {
        [self.delegate tapTopView:self withID:_topModel.id];
    }
    
}

@end
