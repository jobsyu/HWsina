//
//  CinemaViewController.h
//  iMovie
//
//  Created by qianfeng on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "CinemaTableView.h"

@interface CinemaViewController : BaseViewController<UITableViewEventDelegate>

__uiclass(CinemaTableView, tableView);

@end
