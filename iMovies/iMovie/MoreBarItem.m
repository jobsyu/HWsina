//
//  MoreBarItem.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreBarItem.h"

@implementation MoreBarItem

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
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont fontWithName:@"Papyrus" size:12];
    }
    return self;
}

//返回图片的frame
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake((contentRect.size.width - 25)/2, 12, 25,8);
}
//返回标题的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 28, contentRect.size.width, 17);
}

@end
