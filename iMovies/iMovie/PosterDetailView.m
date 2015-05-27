//
//  PosterDetailView.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PosterDetailView.h"
#import "StarView.h"
#import "UIImageView+WebCache.h"

@implementation PosterDetailView{

    UIImageView *_mimageView;
    UILabel *_chTitleLabel;
    UILabel *_enTitleLabel;
    UILabel *_yearLabel;
    StarView *_starview;
    
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
    if(self){
        self.backgroundColor = [UIColor lightGrayColor];
        [self _initSubView];
    }
    return self;
}


-(void)_initSubView{
    _mimageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 80, 120)];
    [self addSubview:_mimageView];
    
    _chTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 15, self.frame.size.width-95-25, 45)];
    _chTitleLabel.textColor = [UIColor blackColor];
    _chTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    _chTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _chTitleLabel.numberOfLines = 0;
    [self addSubview:_chTitleLabel];
    
    _enTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 60, self.frame.size.width-95-25, 45)];
    _enTitleLabel.textColor = [UIColor blackColor];
    _enTitleLabel.font = [UIFont boldSystemFontOfSize:15];
    _enTitleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _enTitleLabel.numberOfLines = 0;
    [self addSubview:_enTitleLabel];
    
    _yearLabel = [[UILabel alloc] initWithFrame:CGRectMake(110, 105+5, self.frame.size.width-95-25, 25)];
    _yearLabel.textColor = [UIColor blackColor];
    _yearLabel.font = [UIFont boldSystemFontOfSize:15];
    _yearLabel.lineBreakMode = NSLineBreakByWordWrapping;
    _yearLabel.numberOfLines = 0;
    [self addSubview:_yearLabel];
    
    _starview = [[StarView alloc] initWithFrame:CGRectZero];
    _starview.style = kNormalStyle;
    _starview.frame = CGRectMake(25, self.frame.size.height/2+40, 200, 50);
    [self addSubview:_starview];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    NSString *imageUrl = [_usaModel.images objectForKey:@"medium"];
    [_mimageView setImageWithURL:[NSURL URLWithString:imageUrl]];
    _chTitleLabel.text = [NSString stringWithFormat:@"中文名:%@",_usaModel.title];
    _enTitleLabel.text = [NSString stringWithFormat:@"英文名:%@",_usaModel.original_title];
    _yearLabel.text = [NSString stringWithFormat:@"年份:%@",_usaModel.year];
    _starview.rating = [[_usaModel.rating objectForKey:@"average"] floatValue];
}


@end
