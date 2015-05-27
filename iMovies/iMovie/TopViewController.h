//
//  TopViewController.h
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "TopTableView.h"

@interface TopViewController : BaseViewController<UITableViewEventDelegate>

__uiclass(TopTableView, tableView);

@end
