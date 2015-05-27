//
//  NewsCell.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsCell.h"
#import "UIImageView+WebCache.h"

#define kImageViewHeight 50
#define kImageViewWith 50


@implementation NewsCell{

    UIImageView *_mImageView;
    UIImageView *_flagView;
    UILabel *_titleLabel;
    UILabel *_contentLabel;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        [self _initSubView];
    }
    return self;
}


#pragma mark init subView
-(void)_initSubView{
    _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, kImageViewWith, kImageViewHeight)];
    _mImageView.layer.cornerRadius = 3;
    _mImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_mImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_mImageView.right+5, 10, kSCREEN_WIDTH-_mImageView.right-5-30, 25)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [self.contentView addSubview:_titleLabel];
    
    _flagView = [[UIImageView alloc] initWithFrame:CGRectMake(_mImageView.right+5, _titleLabel.bottom+8, 15, 10)];
    _flagView.hidden =NO;
    [self.contentView addSubview:_flagView];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(_mImageView.right+5, _titleLabel.bottom, kSCREEN_WIDTH-_flagView.right-30, 25)];
    _contentLabel.textColor = [UIColor grayColor];
    _contentLabel.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:_contentLabel];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    [_mImageView setImageWithURL:[NSURL URLWithString:_newsmodel.image] placeholderImage:[UIImage imageNamed:kMOVIE_DEFUALT_BG]];
    _titleLabel.text = _newsmodel.title;
    int type = _newsmodel.type;
    
    if(type == kWordType){
        _flagView.hidden= YES;
        _contentLabel.frame =CGRectMake(_mImageView.right+5, _titleLabel.bottom, kSCREEN_WIDTH-_flagView.right-30, 25);
        
    }else if (type == kImageType){
        _flagView.hidden = NO;
        _flagView.image = [UIImage imageNamed:kMOVIE_NEWS_TYPE_1];
        _contentLabel.left = _flagView.right+2;
    }else if (type == kMovieType){
        _flagView.hidden = NO;
        _flagView.image = [UIImage imageNamed:kMOVIE_NEWS_TYPE_2];
        _contentLabel.left = _flagView.right+2;
    }
    _contentLabel.text = _newsmodel.summary;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/




@end
