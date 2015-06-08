//
//  HWEmotionKeyboard.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//  表情键盘顶部的内容:scrollView + pageControl

#import "HWEmotionKeyboard.h"

@interface HWEmotionKeyboard()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scrollView;
@property (nonatomic,weak) UIPageControl *pageControl;
@end

@implementation HWEmotionKeyboard

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        //1.UIScrollView
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;
        scrollView.delegate  = self;
        //去除水平方向的滚动条
        scrollView.showsHorizontalScrollIndicator = NO;
        //去除垂直方向的滚动条
        scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        
        // 2.pageControl
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        // 当只有一页时，自动隐藏pageControl
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        // 设置内部的圆点图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKeyPath:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKeyPath:@"currentPageImage"];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}

// 根据emotions，创建对应个数的表情
-(void)setEmotions:(NSArray *)emotions
{
    _emotions = emotions;
    
    //NSUInteger count = (emotions.count + hwEm)
}



@end
