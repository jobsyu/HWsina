//
//  TabBarViewController.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWTabBarViewController.h"
#import "HWNavigationViewController.h"
#import "HWHomeViewController.h"
#import "HWDiscoverViewController.h"
#import "HWMessageCenterViewController.h"
#import "HWProfileViewController.h"
#import "HWTabBar.h"
#import "HWComposeViewController.h"


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
    /*
     [self setValue:tabBar forKeyPath:@"tabBar"];相当于self.tabBar = tabBar;
     [self setValue:tabBar forKeyPath:@"tabBar"];这行代码过后，tabBar的delegate就是HWTabBarViewController
     说明，不用再设置tabBar.delegate = self;
     */
    
    /*
     1.如果tabBar设置完delegate后，再执行下面代码修改delegate，就会报错
     tabBar.delegate = self;
     
     2.如果再次修改tabBar的delegate属性，就会报下面的错误
     错误信息：Changing the delegate of a tab bar managed by a tab bar controller is not allowed.
     错误意思：不允许修改TabBar的delegate属性(这个TabBar是被TabBarViewController所管理的)
     */

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

#pragma mark  －HWTabBarDelegate代理方法
-(void)tabBarDidClickPlusButton:(HWTabBar *)tabBar
{
    HWComposeViewController *compose =[[HWComposeViewController alloc] init];
    
    HWNavigationViewController *nav = [[HWNavigationViewController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}



@end
