//
//  MovieTabBarController.m
//  iMovie
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MovieTabBarController.h"
#import "TabBarItem.h"
#import "MoreBarItem.h"
#import "USAViewController.h"
#import "BaseNavigationController.h"
#import "NewsViewController.h"
#import "TopViewController.h"
#import "CinemaViewController.h"
#import "MoreViewController.h"


#define kBarItemWith 50
#define kTabBarHeight 49
#define kBarItemHeight 45
#define kBarItemSpace (kSCREEN_WIDTH-5*kBarItemWith)/6
#define kSelectIMGHeight 47

@interface MovieTabBarController ()

@end

@implementation MovieTabBarController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.tabBar.hidden = YES;
        self.view.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initSubVies];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark init subViews
-(void)_initSubVies{
    [self createTabBar];
    [self createTabItems];
    [self createViewController];
}


//创建自定义的tabBar
-(void)createTabBar{
    _tabBarView =[[UIView alloc] initWithFrame:CGRectMake(0,kSCREEN_HEIGHT-kTabBarHeight , kSCREEN_WIDTH, kTabBarHeight)];
    _tabBarView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMOVIE_TABBAR_BG]];
    [self.view addSubview:_tabBarView];
}
//向自定义的tabBar上添加按钮
-(void)createTabItems{
    NSArray *titleArray = kMOVIE_TITLE;
    NSArray *imageArray = kMOVIE_IMAGE;
    UIImageView *selectImage = [[UIImageView alloc]initWithFrame:CGRectMake(kBarItemSpace, (kTabBarHeight-kSelectIMGHeight)/2,kBarItemWith, kSelectIMGHeight)];
    selectImage.tag = 112;
    selectImage.image = [UIImage imageNamed:kMOVIE_TABBAR_SELECT_IMG];
    [_tabBarView addSubview:selectImage];
    
    for (int i=0; i<titleArray.count; i++) {
        if(i == 4)
        {
            MoreBarItem *moreBarItem = [MoreBarItem buttonWithType:UIButtonTypeCustom];
            [moreBarItem setTitle:titleArray[i] forState:UIControlStateNormal];
            moreBarItem.frame = CGRectMake(kBarItemSpace+i*(kBarItemSpace+kBarItemWith), (kTabBarHeight-kSelectIMGHeight)/2,kBarItemWith, kSelectIMGHeight);
            [moreBarItem setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            moreBarItem.tag = 100+i;
            [moreBarItem addTarget:self action:@selector(selectBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
            [_tabBarView addSubview:moreBarItem];
        }
        else{
            TabBarItem *tabBarItem = [TabBarItem buttonWithType:UIButtonTypeCustom];
            [tabBarItem setTitle:titleArray[i] forState:UIControlStateNormal];
            tabBarItem.frame = CGRectMake(kBarItemSpace+i*(kBarItemSpace+kBarItemWith), (kTabBarHeight-kSelectIMGHeight)/2,kBarItemWith, kSelectIMGHeight);
            [tabBarItem setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            tabBarItem.tag = 100+i;
            [tabBarItem addTarget:self action:@selector(selectBarItemAction:) forControlEvents:UIControlEventTouchUpInside];
            [_tabBarView addSubview:tabBarItem];
            if(i == 0)
            {
                tabBarItem.selected = YES;
            }
        }
    }
}
//创建视图控制器
-(void)createViewController{
    kMOVIE_VC(USAViewController, usaVC, kMOVIE_TITLE_USA);
    kMOVIE_NAV(BaseNavigationController, usaNav, usaVC);
    
    kMOVIE_VC(NewsViewController, newsVC, kMOVIE_TITLE[1]);
    kMOVIE_NAV(BaseNavigationController, newsNav, newsVC);
    
    kMOVIE_VC(TopViewController, topVC, kMOVIE_TITLE[2]);
    kMOVIE_NAV(BaseNavigationController, topNav, topVC);
    
    kMOVIE_VC(CinemaViewController, cinemaVC, kMOVIE_TITLE[3]);
    kMOVIE_NAV(BaseNavigationController, cinemaNav, cinemaVC);
    
    NSArray *views = @[usaNav,newsNav,topNav,cinemaNav];
    self.viewControllers = views;
    
}


#pragma mark MoreView delegate

-(void)didMoreViewWithTag:(NSInteger)tag{
    
    [self changeViewController:tag];
    
}

-(void)didTableViewCellWithIndex:(NSInteger)index{
    [self hiddenMoreView];
    
    NSMutableArray *views = [NSMutableArray arrayWithArray:self.viewControllers];
    if(views.count >=5){
        [views removeLastObject];
    }
    
    MoreViewController *moreVC = nil;
    if (index == 0) {
        moreVC = [[MoreViewController alloc] initWithTitle:@"搜索"];
    } else if (index == 1){
        moreVC = [[MoreViewController alloc] initWithTitle:@"收藏"];
    } else if (index == 2){
        moreVC = [[MoreViewController alloc] initWithTitle:@"设置"];
    } else {
        moreVC = [[MoreViewController alloc] initWithTitle:@"关于"];
    }
    
    kMOVIE_NAV(BaseNavigationController, moreNav, moreVC);
    [views addObject:moreNav];
    [self setViewControllers:views animated:YES];
    self.selectedIndex =4;
    _lastIndex = 4;
}


-(void)selectBarItemAction:(UIButton *)button{
    NSInteger  index = button.tag-100;
    [self changeViewController:index];
    
}

static NSInteger _lastIndex =0;
-(void)changeViewController:(NSInteger)index{
    
    NSInteger location = (index == 4 && [_moreView superview] ?_lastIndex:index);
    if(index >= 4 && _moreView == nil){
        _moreView = [[MoreView alloc] initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, kSCREEN_HEIGHT-49-20)];
        _moreView.delegate = self;
        _moreView.index = index;
        [self.view addSubview:_moreView];
    }
    else{
        //[self ]
        [self hiddenMoreView];
        self.selectedIndex = location;
    }
    //NSInteger location = (index == 4 && [)
    UIImageView *selectImage =(UIImageView *)[_tabBarView viewWithTag:112];
    [UIView animateWithDuration:0.3 animations:^{
        selectImage.frame = CGRectMake(kBarItemSpace+location*(kBarItemSpace+kBarItemWith),( kSelectIMGHeight-kSelectIMGHeight)/2, kBarItemWith, kSelectIMGHeight);
    }];
    
    _lastIndex = (index == 4)? _lastIndex:index;
}


-(void)hiddenMoreView{
    if([_moreView superview]){
        [UIView animateWithDuration:0.2 animations:^{
            _moreView.alpha = 0;
        }];
        
        [_moreView performSelector:@selector(removeFromSuperview) withObject:nil afterDelay:0.2];
        _moreView.popView = nil;
        _moreView.tableView = nil;
        _moreView = nil;
    }
}


-(void) hiddenTabBarView:(BOOL)isHidden{
    if (isHidden) {
        [UIView animateWithDuration:0.2 animations:^{
            _tabBarView.left = -kSCREEN_WIDTH;
        }];
        
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            _tabBarView.left = 0;
        }];
    }
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
