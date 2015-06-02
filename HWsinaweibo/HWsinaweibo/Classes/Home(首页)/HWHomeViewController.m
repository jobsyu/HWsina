//
//  HomeViewController.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWDropdownMenu.h"
#import "HWTitleButton.h"
#import "HWTitleMenuViewController.h"

@interface HWHomeViewController ()<HWDropdownMenuDelegate>

@end

@implementation HWHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HWColor(211, 211, 211);
    // Do any additional setup after loading the view.
    
    //设置导航栏内容
    [self setupNav];
}

-(void)setupNav{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    
    /*中间的标题按钮 */
    HWTitleButton *titleButton = [[HWTitleButton alloc] init];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    //监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}


-(void)friendsearch
{
    
    
}

-(void)pop
{
   
}

#pragma mark -HWDropdownMenuDelegate
/**
  * 下拉菜单被销毁了
  */

-(void)dropdownMenuDidDismiss:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    //让尖头向下
    titleButton.selected = NO;
}

/**
  * 下拉菜单显示了
  */
-(void)dropdownMenuDidShow:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    //让尖头向上
    titleButton.selected = YES;
}

/**
  * 标题点击
  */
-(void)titleClick:(UIButton *)titleButton
{
    //1.创建下拉菜单
    HWDropdownMenu *menu =[HWDropdownMenu menu];
    menu.delegate = self;
    
    //2.设置内容
    HWTitleMenuViewController *titleVC = [[HWTitleMenuViewController alloc]init];
    titleVC.view.height = 150;
    titleVC.view.width = 150;
    menu.contentController =titleVC;
    
    //3.显示
    [menu showFrom:titleButton];
    
}

@end
