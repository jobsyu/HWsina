//
//  TopViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopViewController.h"
#import "TopModel.h"

@interface TopViewController ()

@end

@implementation TopViewController{
    
    NSMutableArray *_array;
    
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    [self _initSubView];
    // Do any additional setup after loading the view.
}


-(void)_initSubView{
    _tableView = [[TopTableView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 44 -20)];
    _tableView.dataArray = _array;
    [self.view addSubview:_tableView];
    _tableView.eventDelegate = self;
    _tableView.loadMoreTableFooterView.hidden = NO;
}

-(void)_loadData{
    _array = [[NSMutableArray alloc] init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie_list_top" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *dataArray = [TopModel parsingWithJsonData:data];
    
    NSMutableArray *array2D = nil;
    for (int i=0; i<dataArray.count; i++) {
        TopModel *topModel = dataArray[i];
        if (i%3 == 0) {
            array2D = [[NSMutableArray alloc] initWithCapacity:3];
            [_array addObject:array2D];
        }
        [array2D addObject:topModel];
    }
}

#pragma mark UITableView EventDelegate
-(void) LoadMoreTableFooterViewLoadData:(LoadMoreTableFooterView *)loadMoreTableFooterView{
    _tableView.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kSCREEN_HEIGHT - 44 -20 -49);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
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
