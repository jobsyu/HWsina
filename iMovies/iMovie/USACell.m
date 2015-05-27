//
//  USACell.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "USACell.h"
#import "StarView.h"
#import "UIImageView+WebCache.h"

@implementation USACell{
    UIImageView *_mImageView;
    UILabel *_titleLabel;
    UILabel *_dateLabel;
    StarView *_starView;
}


-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
       
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleDefault;
        self.backgroundColor = [UIColor blackColor];
        [self _initSubView];
    }
    return self;
}


-(void)_initSubView{
    _mImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 2, 50, 80)];
    _mImageView.image = [UIImage imageNamed:kMOVIE_DEFUALT_BG];
    _mImageView.layer.cornerRadius = 2;
    _mImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:_mImageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 200, 25)];
    _titleLabel.font = [UIFont boldSystemFontOfSize:18];
    _titleLabel.textColor = [UIColor orangeColor];
    [self.contentView addSubview:_titleLabel];
    
    _dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 35+10, 100, 25)];
    _dateLabel.font = [UIFont systemFontOfSize:15];
    _dateLabel.textColor = [UIColor whiteColor];
    [self.contentView addSubview:_dateLabel];
    
    _starView = [[StarView alloc] initWithFrame:CGRectMake(170,35+16, 120, 25)];
    [self.contentView addSubview:_starView];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    NSString *imageUrl = [_usaModel.images objectForKey:@"small"];
    [_mImageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:kMOVIE_DEFUALT_BG]];
    _titleLabel.text = _usaModel.title;
    _dateLabel.text = [NSString stringWithFormat:@"年份:%@",_usaModel.year];
    _starView.style = kSmallStyle;
    _starView.rating = [[_usaModel.rating objectForKey:@"average"] floatValue];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
