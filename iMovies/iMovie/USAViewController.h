//
//  USAViewController.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "USATableView.h"
#import "USAPosterView.h"

@interface USAViewController : BaseViewController<UITableViewEventDelegate,DownPosterDelegate>

__uiclass(USATableView, listView);

@end
