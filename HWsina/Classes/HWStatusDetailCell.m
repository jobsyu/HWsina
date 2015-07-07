//
//  HWStatusDetailCell.m
//  HWsina
//
//  Created by qianfeng on 15/6/23.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWStatusDetailCell.h"
#import "HWStatusToolbar.h"
#import "HWRetweetedToolbar.h"
#import "HWStatusDetailController.h"
#import "HWTabBarViewController.h"
#import "HWNavigationViewController.h"

@interface HWStatusDetailCell()
//被转发的微博工具条
@property (nonatomic,weak) HWRetweetedToolbar *retweettoolbar;
@property (nonatomic,weak) HWStatusToolbar *toolbar;
@end

@implementation HWStatusDetailCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //1.操作条
        HWStatusToolbar *toolbar = [HWStatusToolbar toolbar];
        //toolbar.autoresizingMask =
        CGFloat toolbarX = 0;
        CGFloat toolbarW = [UIScreen mainScreen].bounds.size.width;
        CGFloat toolbarH = 35;
        CGFloat toolbarY =  [UIScreen mainScreen].bounds.size.height - toolbarH;
        toolbar.frame = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
        [self addSubview:toolbar];
        _toolbar = toolbar;
        
        HWRetweetedToolbar *retweetToolbar = [HWRetweetedToolbar toolbar];
        
        CGFloat x = self.retweetView.frame.size.width - retweetToolbar.size.width;
        CGFloat y = self.retweetView.frame.size.height - retweetToolbar.size.height;
        retweetToolbar.frame = CGRectMake(x, y, 0, 0);
        [self.retweetView addSubview:retweetToolbar];
        self.retweettoolbar =retweetToolbar;
        
        //监听被转发微博的点击
        [self.retweetView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showRetweeted)]];
    }
    return self;
}


-(void)showRetweeted
{
    //展示被点击微博
    HWStatusDetailController *detail = [[HWStatusDetailController alloc] init];
    detail.status = self.retweettoolbar.status;
    
    HWTabBarViewController *main = (HWTabBarViewController *)self.window.rootViewController;
    
    HWNavigationViewController *nav = (HWNavigationViewController *)main.selectedViewController;
    
    [nav pushViewController:detail animated:YES];
}


-(void)setStatusCellFrame:(HWBaseStatusCellFrame *)statusCellFrame
{
    [super setStatusCellFrame:statusCellFrame];
    
    _retweettoolbar.status = self.status;
}

@end
