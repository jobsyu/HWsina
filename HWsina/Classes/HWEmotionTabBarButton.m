//
//  HWEmotionTabBarButton.m
//  HWsina
//
//  Created by qianfeng on 15/6/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWEmotionTabBarButton.h"

@implementation HWEmotionTabBarButton

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        //设置字体
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

-(void)setHighlighted:(BOOL)highlighted
{
   //按钮高粱所做的一切操作都不在了
}

@end
