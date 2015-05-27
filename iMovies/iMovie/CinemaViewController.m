//
//  CinemaViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CinemaViewController.h"
#import "CinemaModel.h"
#import "DetailViewController.h"
#import "MovieTabBarController.h"

@interface CinemaViewController ()

@end

@implementation CinemaViewController{
   
    NSArray *_array;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    [self _initSubView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) _initSubView{
    _tableView = [[CinemaTableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 44 -20)];
    _tableView.dataArray = _array;
    _tableView.eventDelegate = self;
    [self.view addSubview:_tableView];
    _tableView.loadMoreTableFooterView.hidden = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void) _loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"readyMovie_cinnema" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _array = [CinemaModel parsingWithJsonData:data];
    //NSArray *array = [NSJSONSerialization ]
    //NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    //NSMutableArray *cinemaArray = [[NSMutableArray alloc] init];
    //for (int i=0; i<array.count; i++) {
        //CinemaModel *model =[[CinemaModel alloc] init];
        //[model setModelData:array[i]];
        //[cinemaArray addObject:model];
    //}
    //_array = cinemaArray;
    
}


#pragma mark UITableView EventDelegate
-(void)LoadMoreTableFooterViewLoadData:(LoadMoreTableFooterView *)loadMoreTableFooterView{
    _tableView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 44 -20 -49);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
    MovieTabBarController *tabBarVC = (MovieTabBarController *)self.tabBarController;
    [tabBarVC hiddenTabBarView:YES];
}

@end
