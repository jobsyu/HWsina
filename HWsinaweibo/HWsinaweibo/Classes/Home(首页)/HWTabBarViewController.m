//
//  TabBarViewController.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HWConst.h"
#import "HWNavigationViewController.h"
#import "HWHomeViewController.h"
#import "HWDiscoverViewController.h"
#import "HWMessageCenterViewController.h"
#import "HWProfileViewController.h"
#import "HWTabBar.h"


@interface HWTabBarViewController () <HWTabBarDelegate>

@end

@implementation HWTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1.初始化子控制器
    //首页
    HWHomeViewController *home =[[HWHomeViewController alloc] init];
    [self addChildVC:home title:@"首页" image:@"tabbar_home"
                   selectedImage:@"tabbar_home_selected"];
    //消息
    HWMessageCenterViewController *messagecenter =[[HWMessageCenterViewController alloc] init];
    [self addChildVC:messagecenter title:@"消息" image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected"];
    //发现
    HWDiscoverViewController *discover =[[HWDiscoverViewController alloc] init];
    [self addChildVC:discover title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected"];
    //我
    HWProfileViewController *profile =[[HWProfileViewController alloc] init];
    [self addChildVC:profile title:@"我" image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected"];
    
    // 2.更换系统自带的tabbar
    HWTabBar *tabBar = [[HWTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    //设置子控制器的文字
    childVC.title =title; //同时设置tabbar和navigationBar的标题
    
    //设置子控制器的图片
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage =[[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = HWColor(123, 123, 123);
    NSMutableDictionary  *selecttextAttrs = [NSMutableDictionary dictionary];
    selecttextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    [childVC.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    [childVC.tabBarItem setTitleTextAttributes:selecttextAttrs forState:UIControlStateSelected];
    
    //先给外面传进来的小控制器 包装一个导航控制器
    HWNavigationViewController *nav = [[HWNavigationViewController alloc] initWithRootViewController:childVC];
    
    //添加为子控制器
    [self addChildViewController:nav];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
