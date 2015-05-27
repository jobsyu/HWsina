//
//  BaseTableView.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self _initViews];
    }
    return self;
}

-(void)awakeFromNib{
    [self _initViews];
}

-(void)_initViews{
    if(_refreshTableHeaderView == nil){
       _refreshTableHeaderView = [[EGORefreshTableHeaderView alloc]
                                  initWithFrame:CGRectMake(0.0f,0.0f-self.bounds.size.height,self.frame.size.width,self.bounds.size.height)];
        _refreshTableHeaderView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
        _refreshTableHeaderView.lastUpdatedLabel.textColor = [UIColor whiteColor];
        _refreshTableHeaderView.statusLabel.textColor = [UIColor whiteColor];
        _refreshTableHeaderView.lastUpdatedLabel.font = [UIFont systemFontOfSize:13];
        _refreshTableHeaderView.statusLabel.font = [UIFont systemFontOfSize:13];
        _refreshTableHeaderView.delegate = self;
    }
    
    //update the last update time
    [_refreshTableHeaderView refreshLastUpdatedDate];
    
    if(_loadMoreTableFooterView == nil){
        _loadMoreTableFooterView = [[LoadMoreTableFooterView alloc] initWithFrame:CGRectMake(0,self.contentSize.height, self.bounds.size.width, self.bounds.size.height)];
        _loadMoreTableFooterView.delegate = self;
        _loadMoreTableFooterView.hidden = YES;
        _loadMoreTableFooterView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
        _loadMoreTableFooterView.statusLabel.textColor = [UIColor whiteColor];
        _loadMoreTableFooterView.statusLabel.font = [UIFont systemFontOfSize:13];
                                                                                             
    }
    
    [self addSubview:_refreshTableHeaderView];
    [self addSubview:_loadMoreTableFooterView];
    
    self.dataSource = self;
    self.delegate = self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _loadMoreTableFooterView.frame = CGRectMake(0,self.contentSize.height, self.bounds.size.width, self.bounds.size.height);
}

#pragma mark UITableView Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.eventDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark UIScrollView  delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_refreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
    [_loadMoreTableFooterView loadMoreScrollViewDidScroll:scrollView];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [_refreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    [_loadMoreTableFooterView loadMoreScrollViewDidEndDragging:scrollView];
}

#pragma mark LoadMoreTableFooterView delegate
-(void)loadMoreTableFooterDidTriggerLoadMore:(LoadMoreTableFooterView *)view{
    _reloading = YES;
    if([self.eventDelegate respondsToSelector:@selector(LoadMoreTableFooterViewLoadData:)]){
        [self.eventDelegate LoadMoreTableFooterViewLoadData:_loadMoreTableFooterView];
    }
    [self performSelector:@selector(doneFooterLoadingTableViewData) withObject:nil afterDelay:2];
}

-(BOOL)loadMoreTableFooterDataSourceIsLoading:(LoadMoreTableFooterView *)view{
   
    return _reloading;
}

#pragma mark EGORefreshTableHeaderView delegate
-(void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view{
    _reloading = YES;
    if([self.eventDelegate respondsToSelector:@selector(EGORefreshTableHeaderViewLoadData:)]){
        [self.eventDelegate EGORefreshTableHeaderViewLoadData:_refreshTableHeaderView];
    }
    [self performSelector:@selector(doneHeaderLoadingTableViewData) withObject:nil afterDelay:2];
}

-(BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view{
    
    return _reloading;
}

-(NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view{
    return [NSDate date];
}

-(void)doneFooterLoadingTableViewData{
    _reloading = NO;
    [_loadMoreTableFooterView loadMoreScrollViewDataSourceDidFinishedLoading:self];
}

-(void)doneHeaderLoadingTableViewData{
    _reloading = NO;
    [_refreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}


@end
