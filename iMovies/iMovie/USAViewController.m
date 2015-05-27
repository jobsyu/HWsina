//
//  USAViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "USAViewController.h"
#import "USAModel.h"
#import "UIUtils.h"
#import "DetailViewController.h"
#import "MovieTabBarController.h"


#define kPosterBtn_tag 101
#define kListBtn_tag 102
#define kRightItemWith 50
#define kRightItemHeight 36

@interface USAViewController ()

@end

@implementation USAViewController{
    NSArray *_dataArray;
    UIView *_posterView;
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.view.backgroundColor = [UIColor blackColor];
        [self _createPosterBtn];
    }
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self loadData];
    [self _initSubView];
}


-(void)loadData{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NorthUSA" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    //USAModel *model = [[USAModel alloc] init];
    _dataArray = [USAModel parsingWithJsonData:data];

}


#pragma mark init UI
-(void)_createPosterBtn{
    UIImageView *itemView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRightItemWith, kRightItemHeight)];
    itemView.userInteractionEnabled = YES;
    itemView.image = [UIImage imageNamed:kMOVIE_USA_RIGHT_BG];
    
    UIButton *posterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    posterBtn.tag = kPosterBtn_tag;
    [posterBtn setImage:[UIImage imageNamed:kMOVIE_USA_RIGHT_POSTER_IMG] forState:UIControlStateNormal];
    posterBtn.frame = CGRectMake(0, 0, kRightItemWith, kRightItemHeight);
    [posterBtn addTarget:self action:@selector(showPosterAction) forControlEvents:UIControlEventTouchUpInside];
    posterBtn.hidden = YES;
    [itemView addSubview:posterBtn];
    
    UIButton *listBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    listBtn.tag = kListBtn_tag;
    [listBtn setImage:[UIImage imageNamed:kMOVIE_USA_RIGHT_LIST_IMG] forState:UIControlStateNormal];
    listBtn.frame = CGRectMake(0, 0, kRightItemWith, kRightItemHeight);
    [listBtn addTarget:self action:@selector(showPosterAction) forControlEvents:UIControlEventTouchUpInside];
    listBtn.hidden = NO;
    [itemView addSubview:listBtn];
    
    UIBarButtonItem *rightPoster =[[UIBarButtonItem alloc] initWithCustomView:itemView];
    self.navigationItem.rightBarButtonItem =rightPoster;
    
}

-(void)_initSubView{
    //list view
    _listView = [[USATableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-44-20)];
    _listView.dataArray = _dataArray;
    _listView.eventDelegate =self;
    _listView.hidden = YES;
    [self.view addSubview:_listView];
    [_listView reloadData];
    _listView.loadMoreTableFooterView.hidden = NO;
   //海报视图初始化
    _posterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-44-20)];
    _posterView.backgroundColor = [UIColor clearColor];
    USAPosterView *usaPosterView = [[USAPosterView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT-44-20)];
    usaPosterView.models = self.listView.dataArray;
    
    _posterView.hidden = NO;
    [_posterView addSubview:usaPosterView];
    [self.view addSubview:_posterView];
}

//动画切换
-(void)showPosterAction{
    UIImageView *itemView = (UIImageView*)[self.navigationItem.rightBarButtonItem customView];
    UIButton * posterBtn = (UIButton *)[itemView viewWithTag:kPosterBtn_tag];
    UIButton * listBtn = (UIButton *)[itemView viewWithTag:kListBtn_tag];
    
    [UIUtils animationWithButton:posterBtn listView:listBtn superView:itemView];
    [UIUtils animationWith:_listView listView:_posterView superView:self.view];
}

#pragma  mark UITableView EventDelegate
-(void)LoadMoreTableFooterViewLoadData:(LoadMoreTableFooterView *)loadMoreTableFooterView{
    _listView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 44 -20 -49);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    MovieTabBarController *tabBarVC = (MovieTabBarController *)self.tabBarController;
    [tabBarVC hiddenTabBarView:YES];
}

@end
