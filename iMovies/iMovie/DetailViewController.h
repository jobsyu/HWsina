//
//  DetailViewController.h
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import "NewsDetailModel.h"
#import "CommentTableView.h"

@interface DetailViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>

//__class()
__class(NewsDetailModel, model);
__uiclass(CommentTableView, commentTableView);
__sysclass(NSArray, commentList);

@end
