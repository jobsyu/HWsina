//
//  CinemaCell.m
//  iMovie
//
//  Created by qianfeng on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CinemaCell.h"
#import "UIImageView+WebCache.h"

#define kMImageViewWith 60
#define kMImageViewHeight 80

#define kDateImageViewWith 40
#define kDateImageViewHeight 40

#define kMonthLabelTag 20001
#define kDayLabelTag 20002

@implementation CinemaCell{
    UIImageView *_mImageView;
    UIImageView *_dateImageView;
    UILabel *_titleLabel;
    UILabel *_typeLabel;
    UILabel *_directorLabel;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
   
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initSubView];
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}

-(void)_initSubView{
    _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kMImageViewWith, kMImageViewHeight)];
    _mImageView.layer.cornerRadius = 2;
    _mImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_mImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_mImageView.right+10, 15, kSCREEN_WIDTH-2*(_mImageView.right+10), 20)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    _titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:_titleLabel];
    
    _typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(_mImageView.right+10, _titleLabel.bottom+5,kSCREEN_WIDTH-2*(_mImageView.right+10), 20)];
    _typeLabel.font = [UIFont boldSystemFontOfSize:14];
    _typeLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_typeLabel];
    
    _directorLabel = [[UILabel alloc] initWithFrame:CGRectMake(_mImageView.right+10, _typeLabel.bottom+5,kSCREEN_WIDTH-2*(_mImageView.right+10), 20)];
    _directorLabel.font = [UIFont boldSystemFontOfSize:14];
    _directorLabel.textColor = [UIColor grayColor];
    [self.contentView addSubview:_directorLabel];
    
    _dateImageView =[[UIImageView alloc] initWithFrame:CGRectMake(_typeLabel.right, 30, kDateImageViewWith, kDateImageViewHeight)];
    _dateImageView.layer.cornerRadius = 5;
    _dateImageView.layer.masksToBounds = YES;
    _dateImageView.image = [UIImage imageNamed:kMOVIE_CINEMA_THEATER_IMG];
    [self.contentView addSubview:_dateImageView];
    
    UILabel *monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kDateImageViewWith, kDateImageViewHeight/2)];
    monthLabel.textAlignment = NSTextAlignmentCenter;
    monthLabel.font = [UIFont boldSystemFontOfSize:13];
    monthLabel.textColor = [UIColor whiteColor];
    monthLabel.backgroundColor = [UIColor clearColor];
    monthLabel.tag  = kMonthLabelTag;
    [_dateImageView addSubview:monthLabel];
    
    UILabel *dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, monthLabel.bottom, kDateImageViewWith, kDateImageViewHeight/2)];
    dayLabel.textAlignment = NSTextAlignmentCenter;
    dayLabel.font = [UIFont boldSystemFontOfSize:13];
    dayLabel.textColor = [UIColor blackColor];
    dayLabel.backgroundColor = [UIColor clearColor];
    dayLabel.tag = kDayLabelTag;
    [_dateImageView addSubview:dayLabel];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [_mImageView setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:kMOVIE_DEFUALT_BG]];
    _titleLabel.text = _model.title;
    _typeLabel.text = _model.type;
    _directorLabel.text = _model.director;
    
    //对日期数据进行截取
    NSString *str = _model.releaseDate;
    NSArray *array = [str componentsSeparatedByString:@"日"];
    NSString *dayStr = [array[0] substringFromIndex:2];
    NSString *monthStr = [array[0] substringToIndex:2];
    
    UILabel *monthLabel = (UILabel *)[_dateImageView viewWithTag:kMonthLabelTag];
    monthLabel.text = monthStr;
    
    UILabel *dayLabel = (UILabel *)[_dateImageView viewWithTag:kDayLabelTag];
    dayLabel.text = dayStr;
    
}




@end
