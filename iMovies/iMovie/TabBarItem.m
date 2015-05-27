//
//  TabBarItem.m
//  iMovie
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TabBarItem.h"

@implementation TabBarItem



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
    
    return CGRectMake((contentRect.size.width - 25)/2, 2, 25, 25);
}
//返回标题的frame
-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(0, 28, contentRect.size.width, 17);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
