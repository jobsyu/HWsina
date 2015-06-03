//
//  HWNewfeatureViewController.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/3.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWNewfeatureViewController.h"

#define HWNewfeatureCount 4

@interface HWNewfeatureViewController() <UIScrollViewDelegate>
@property (nonatomic,weak) UIPageControl *pageControl;

@property (nonatomic,weak) UIScrollView *scrollView;
@end

@implementation HWNewfeatureViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    //1.创建一个scrollView:显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.view.bounds;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2.添加图片到scrollView中
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i<HWNewfeatureCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i *scrollW;
        //显示图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1];
        imageView.image = [UIImage imageNamed:name];
        [scrollView addSubview:imageView];
        
        if (i == HWNewfeatureCount - 1) {
           //[self ]
        }
    }
    
#warning 默认情况下，scrollView一创建出来，它里面可能就存在一些子控件了
#warning 就算不主动添加子控件到scrollView中，scrollView内部还是可能会有一些子控件
    // 3.设置scrollView的其他属性
    // 如果想要在某个方向上不能滚动，那么这个方向对应的尺寸数值传0即可
    scrollView.contentSize =CGSizeMake(HWNewfeatureCount * scrollW, 0);
    scrollView.bounces =NO; //去除弹簧效果
    scrollView.pagingEnabled =YES;
    scrollView.showsHorizontalScrollIndicator =NO;
    scrollView.delegate =self;
    
    // 4.添加pageControl：分页，展示目前看的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = HWNewfeatureCount;
    pageControl.backgroundColor = [UIColor redColor];
    pageControl.currentPageIndicatorTintColor = HWColor(253, 98, 42);
    pageControl.pageIndicatorTintColor = HWColor(189, 189, 189);
    pageControl.centerX = scrollW * 0.5;
    pageControl.centerY = scrollH - 50;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
}

@end
