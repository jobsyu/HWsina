//
//  StarView.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "StarView.h"
#define kNolmalWith 30
#define kNolmalHeight 28
#define kSmallWith 12
#define kSmallHeight 11
#define kFullMark 10

#define kSmallFont 12
#define kNormalFont 24
@implementation StarView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initGrayStarView];
        [self initYellowStarView];
        [self initStarViewLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initGrayStarView];
        [self initYellowStarView];
        [self initStarViewLabel];
    }
    return self;
}

-(void) initGrayStarView{
    grayStarArray = [[NSMutableArray alloc] initWithCapacity:5];
    for (int i = 0; i<5; i++) {
        UIImageView *grayStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        grayStarView.image = [UIImage imageNamed:@"gray.png"];
        [self addSubview:grayStarView];
        [grayStarArray addObject:grayStarView];
    }
    
}

-(void) initYellowStarView{
    
    yellowStarArray = [[NSMutableArray alloc] initWithCapacity:5];
    _baseView = [[UIView alloc] initWithFrame:CGRectZero];
    _baseView.backgroundColor = [UIColor clearColor];
    _baseView.clipsToBounds = YES;
    [self addSubview:_baseView];
    
    for (int i = 0; i<5; i++) {
        UIImageView *yellowStarView = [[UIImageView alloc] initWithFrame:CGRectZero];
        yellowStarView.image = [UIImage imageNamed:@"yellow.png"];
        [_baseView addSubview:yellowStarView];
        [yellowStarArray addObject:yellowStarView];
    }
}

-(void) initStarViewLabel{
    starLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:starLabel];
    
}

-(void) setRating:(CGFloat)rating{
    
    starLabel.textColor = [UIColor purpleColor];
    _rating = rating;
    starLabel.text = [NSString stringWithFormat:@"%0.1f",_rating];
}

-(void) layoutSubviews{
    
    [super layoutSubviews];
    int with = 0;
    for (int i = 0; i<5; i++) {
        
        UIView *yellowView = yellowStarArray[i];
        UIView *grayView = grayStarArray[i];
        if (self.style == kSmallStyle) {
            grayView.frame = CGRectMake(0+with, 0, kSmallWith, kSmallHeight);
            yellowView.frame = CGRectMake(0+with, 0, kSmallWith, kSmallHeight);
            with+=kSmallWith;
        }else{
            grayView.frame = CGRectMake(0+with, 0, kNolmalWith, kNolmalHeight);
            yellowView.frame = CGRectMake(0+with, 0, kNolmalWith, kNolmalHeight);
            with+=kNolmalWith;
            
        }
        
    }
    float baseViewWith = 0;
    baseViewWith = _rating/kFullMark*with;
    
    
    int hieght = 0;
    if (self.style == kSmallStyle) {
        _baseView.frame =CGRectMake(0, 0, baseViewWith, kSmallHeight);
        starLabel.font = [UIFont boldSystemFontOfSize:kSmallFont];
        hieght = kSmallHeight;
    }else{
        _baseView.frame =CGRectMake(0, 0, baseViewWith, kNolmalHeight);
        starLabel.font = [UIFont boldSystemFontOfSize:kNormalFont];
        hieght = kNolmalHeight;
    }
    starLabel.frame = CGRectMake(with, 0, 0, 0);
    [starLabel sizeToFit];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, with+starLabel.frame.size.width, hieght);
    
}

@end
