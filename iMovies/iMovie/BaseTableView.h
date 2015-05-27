//
//  BaseTableView.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoadMoreTableFooterView.h"
#import "EGORefreshTableHeaderView.h"

@protocol UITableViewEventDelegate <NSObject>

@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
-(void)LoadMoreTableFooterViewLoadData:(LoadMoreTableFooterView *)loadMoreTableFooterView;
-(void)EGORefreshTableHeaderViewLoadData:(EGORefreshTableHeaderView *)refreshTableHeaderView;

@end

@interface BaseTableView : UITableView<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,LoadMoreTableFooterDelegate,EGORefreshTableHeaderDelegate>

__sysclass(NSArray, dataArray);

__delegate(UITableViewEventDelegate, eventDelegate);

__uiclass(LoadMoreTableFooterView, loadMoreTableFooterView);
__uiclass(EGORefreshTableHeaderView, refreshTableHeaderView);
__BOOL(reloading);
@end
