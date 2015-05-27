//
//  MoreView.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreViewDelegate <NSObject>

-(void)didMoreViewWithTag:(NSInteger)index;
-(void)didTableViewCellWithIndex:(NSInteger)index;

@end

@interface MoreView : UIView<UITableViewDelegate,UITableViewDataSource>

__uiclass(UITableView, tableView);
__uiclass(UIImageView, popView);
__NSInteger(index);
__delegate(MoreViewDelegate, delegate);

@end
