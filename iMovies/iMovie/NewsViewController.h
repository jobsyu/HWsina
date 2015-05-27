//
//  NewsViewController.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsTableView.h"
#import "NewsHeaderView.h"

@interface NewsViewController : BaseViewController<TapHeaderImageViewDelegate,UIScrollViewDelegate,UITableViewEventDelegate,NewsTableViewDelegate>

__uiclass(NewsTableView,tableView);

@end
