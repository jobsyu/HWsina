//
//  NewsTableView.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseTableView.h"
#import "NewsCell.h"

@protocol NewsTableViewDelegate <NSObject>

@optional
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface NewsTableView : BaseTableView

__delegate(NewsTableViewDelegate, didDelegate);

@end
