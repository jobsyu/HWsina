//
//  NewsViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsModel.h"
#import "DetailViewController.h"
#import "AlbumViewController.h"
#import "MovieTabBarController.h"

@interface NewsViewController ()

@end

@implementation NewsViewController{
    
    UIScrollView *_headerView;
    NSArray *_array;
    int _index;
}


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
       
    }
    return self;
}

#pragma mark init SubView
-(void)_initView{
   //头部滚动视图
    _headerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, 160)];
    _headerView.pagingEnabled = YES;
    _headerView.showsVerticalScrollIndicator = NO;
    _headerView.delegate =self;
    
    for (int i=0; i<_array.count; i++) {
        NewsHeaderView *newsView = [[NewsHeaderView alloc] initWithFrame:CGRectMake(i*kSCREEN_WIDTH, 0, kSCREEN_WIDTH, 160)];
        newsView.delegate = self;
        NewsModel *model = _array[i];
        newsView.newsModel = model;
        [_headerView addSubview:newsView];
    }
    _headerView.contentSize = CGSizeMake(_array.count*kSCREEN_WIDTH, _headerView.height);
    //_tableView = [[NewsTableView alloc] initWithFrame:]
    _tableView =[[NewsTableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-44-20)];
    _tableView.dataArray = _array;
    _tableView.didDelegate = self;
    _tableView.eventDelegate = self;
    _tableView.tableHeaderView =_headerView;
    [self.view addSubview:_tableView];
    _tableView.loadMoreTableFooterView.hidden =NO;
    _index = 0;
    
    if (_tableView.dataArray.count > 0) {
        [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(autoScrollView) userInfo:nil repeats:YES];
    }
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [self _initView];
    // Do any additional setup after loading the view.
}

-(void)autoScrollView{
    _index ++;
    if(_index > self.tableView.dataArray.count -1){
        _index = 0;
        [_headerView setContentOffset:CGPointMake(_index*kSCREEN_WIDTH, 0) animated:NO];
    }else{
        [_headerView setContentOffset:CGPointMake(_index*kSCREEN_WIDTH, 0) animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UIScrollView delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    _index = scrollView.contentOffset.x/kSCREEN_WIDTH;
}

#pragma mark NewsTableView didDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsModel *model = _tableView.dataArray[indexPath.row];
    if (model.type == kWordType) {
        DetailViewController *wordNewsVC =[[DetailViewController alloc] initWithTitle:@"电影详情"];
        [self.navigationController pushViewController:wordNewsVC animated:YES];
        [self hiddenTabBar:YES];
    }else if(model.type == kImageType){
        AlbumViewController *albumVC = [[AlbumViewController alloc] init];
        [self.navigationController pushViewController:albumVC animated:YES];
        [self hiddenTabBar:YES];
    }else if (model.type == kMovieType){
        
    }
}

#pragma mark load data
-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news_list" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _array = [NewsModel parsingWithJsonData:data];
}

#pragma mark UITableView   EventDelegate
-(void) LoadMoreTableFooterViewLoadData:(LoadMoreTableFooterView *)loadMoreTableFooterView{
    _tableView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 44 -20 -49);
}

#pragma mark NewsHeaderView Delegate
-(void)tapNewsHeaderImageView:(id)target withID:(long)newsId{

    NSLog(@"%ld",newsId);
}


-(void)hiddenTabBar:(BOOL)isHiden{
    MovieTabBarController *tabBarVC = (MovieTabBarController *)self.tabBarController;
    [tabBarVC hiddenTabBarView:isHiden];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
