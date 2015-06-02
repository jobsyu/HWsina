//
//  DiscoverViewController.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWDiscoverViewController.h"
#import "HWSearchBar.h"

@interface HWDiscoverViewController ()

@end

@implementation HWDiscoverViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建搜索框对象
    HWSearchBar *searchBar = [HWSearchBar searchBar];
    searchBar.width = 300;
    searchBar.height = 30;
    self.navigationItem.titleView = searchBar;
}


@end
