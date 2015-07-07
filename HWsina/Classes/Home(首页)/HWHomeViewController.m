//
//  HomeViewController.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWHomeViewController.h"
#import "HWDropdownMenu.h"
#import "HWTitleButton.h"
#import "HWTitleMenuViewController.h"
#import "AFNetworking.h"
#import "HWAccountTool.h"
#import "HWAccount.h"
#import "HWUser.h"
#import "MJExtension.h"
#import "HWLoadMoreFooter.h"
#import "HWStatus.h"
#import "HWStatusCellFrame.h"
#import "HWStatusCell.h"
#import "HWHomeStatusesParam.h"
#import "HWHomeStatusesResult.h"
#import "HWUserInfoParam.h"
#import "HWUserInfoResult.h"
#import "HWUserTool.h"
#import "HWStatusTool.h"
#import "MJRefresh.h"
#import "HWStatusDetailController.h"


@interface HWHomeViewController ()<HWDropdownMenuDelegate>
/**
  *  微博数组（里面放的都是HWStatusFrame模型，一个HWStatusFrame对象就代表一条微博）
  */
@property (nonatomic,strong) NSMutableArray *statusFrames;

@end

@implementation HWHomeViewController

-(NSMutableArray *)statusFrames
{
    if (!_statusFrames) {
        self.statusFrames = [NSMutableArray array];
    }
    return _statusFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = HWGlobeTableViewBackgroundColor;
    // Do any additional setup after loading the view.
    
    // 1.设置导航栏内容
    [self setupNav];
    
    // 2.获得用户信息（昵称）
    [self setupUserInfo];
    
    // 3.集成刷新控件
    [self setupRefresh];
    
}

-(void)setupNav{
    /* 设置导航栏上面的内容 */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(friendsearch) image:@"navigationbar_friendsearch" highImage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self action:@selector(pop) image:@"navigationbar_pop" highImage:@"navigationbar_pop_highlighted"];
    
    
    /*中间的标题按钮 */
    HWTitleButton *titleButton = [[HWTitleButton alloc] init];
    [titleButton setTitle:@"首页" forState:UIControlStateNormal];
    //监听标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = titleButton;
}

/**
 *  获得用户信息（昵称）
 */
-(void)setupUserInfo
{
    // 1.封装请求参数
    HWAccount *account = [HWAccountTool account];
    HWUserInfoParam *userInfoParam = [HWUserInfoParam param];
    userInfoParam.uid = account.uid;
    
    // 2.加载用户信息
    [HWUserTool userInfoWithParam:userInfoParam success:^(HWUserInfoResult *user) {
        //标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //存储昵称到沙盒中
        account.name = user.name;
        [HWAccountTool saveAccount:account];
    } failure:^(NSError *error) {
        HWLog(@"请求失败－%@",error);
    }];
}
/**
 *  集成下拉刷新控件
 */
-(void)setupRefresh
{
    //集成下拉刷新控件
    [self setupDownRefresh];
    
    //集成上拉刷新控件
    [self setupUpRefresh];

}

/**
 *  集成下拉刷新控件
 */
-(void)setupDownRefresh
{
//    __weak __typeof(self) weakSelf =self;
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.header = [MJRefreshHeader headerWithRefreshingBlock:^{
//        [weakSelf loadNewStatus];
//    }];
    //1.添加刷新控件
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    //只有用户通过手动下拉刷新，才会触发UIControlEventValueChanged事件
    [control addTarget:self action:@selector(loadNewStatus:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:control];
    
    //2.马上进入刷新状态（仅仅是显示刷新状态，并不会触发UIControlEventValueChanged事件）
    [control beginRefreshing];
    
    //加载数据
    [self loadNewStatus:control];
    //[self.tableView.header beginRefreshing];
}

/** 
  *  集成上拉刷新控件
  */
-(void)setupUpRefresh
{
//    __weak __typeof(self) weakSelf = self;
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.footer = [MJRefreshFooter footerWithRefreshingBlock:^{
//        [weakSelf loadMoreStatus];
//    }];
//    
//    [self.tableView.footer beginRefreshing];
    HWLoadMoreFooter *footer = [[HWLoadMoreFooter alloc] init];
    footer.hidden = YES;
    self.tableView.tableFooterView =footer;
}

//将 HWStatus数组 转为 HWStatusFrame数组
-(NSArray *)statusFramesWithStatuses:(NSArray *)statuses
{
    NSMutableArray *frames = [NSMutableArray array];
    for (HWStatus *status in statuses) {
        HWStatusCellFrame *f = [[HWStatusCellFrame alloc] init];
        f.status  = status;
        [frames addObject:f];
    }
    return frames;
}

/**
  *  UIRefreshControl进入刷新状态：加载最新的数据
  */
-(void)loadNewStatus:(UIRefreshControl *)control
{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)),
//        dispatch_get_main_queue(), ^{
//            NSDictionary *responseObject = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeStatus" ofType:@"plist"]];
//        // 将“微博字典”数组 转为 “微博模型”数组
//            NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//            // 将 HWStatus数组 转为 HWStatusFrame数组
//            NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
//            
//            //将最新的微博数据，添加到总数组的最前面
//            NSRange range = NSMakeRange(0, newFrames.count);
//            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//            [self.statusFrames  insertObjects:newFrames atIndexes:set];
//            
//            //刷新表格
//            [self.tableView reloadData];
//            
//            //结束刷新
//            [control endRefreshing];
//            
//            //显示最新微博的数量
//            [self showNewStatusCount:newStatuses.count];
//    });
//    
//    return;
    
    // 1.封装请求参数
    HWHomeStatusesParam *param = [HWHomeStatusesParam param];
    
    // 取出最前面的微博（最新的微博，ID最大的微博）
    HWStatusCellFrame *firstStatusF = [self.statusFrames firstObject];
    HWStatus *firstStatus = firstStatusF.status;
    if (firstStatus) {
        // 若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0
        param.since_id = @(firstStatus.ID);
    }
    // 2.加载微博数据
    [HWStatusTool homeStatusesWithParam:param success:^(NSArray *statues) {
        
        //将“微博字典”数组 转为 “微博模型”数组
        //NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        
        //将HWStatus数组 转为 HWStatusFrame数组(获得最新的微博frame数组)
        NSArray *newFrames = [self statusFramesWithStatuses:statues];
        
        //将最新的微博数据，添加到总数组的最前面
        NSRange range = NSMakeRange(0, newFrames.count);
        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.statusFrames insertObjects:newFrames atIndexes:set];
        
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        //[self.tableView.header endRefreshing];
        [control endRefreshing];
        
        // 显示最新微博的数量
        [self showNewStatusCount:statues.count];
    } failure:^(NSError *error) {
        HWLog(@"请求失败－%@",error);
        
        //结束刷新
        //[self.tableView.header endRefreshing];
        [control endRefreshing];
    }];
}

/**
 *  显示最新微博的数量
 *
 *  @param count 最新微博的数量
 */
-(void)showNewStatusCount:(NSUInteger)count
{
    //刷新成功（清空图标数字）
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
    
    //1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor  = [UIColor colorWithPatternImage:[UIImage
        imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    label.x = 0;
    label.y = HWNavigationHeight - label.height;
    
    // 2.设置其他属性
    if(count == 0){
        label.text = @"没有新的微博数据，稍后再试";
    } else {
        label.text = [NSString stringWithFormat:@"共有%zd条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:16];
    
    //3。添加
    //将label添加到导航控制器的view中，并且是盖在导航栏下边
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //4.动画
    //先利用1s的时间 ，让label往下移动一段距离
    CGFloat duration = 1.0; //动画的时间
    [UIView animateWithDuration:duration animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, label.height);
    } completion:^(BOOL finished) {
        //延迟1s后，再利用1s的时间，让label往上移动一段距离（回到一开始的状态）
        CGFloat delay  = 1.0; //延迟1s
        //UIViewAnimationOptionCurveLinear:匀速
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear
                animations:^{
                    label.transform =CGAffineTransformIdentity;
                } completion:^(BOOL finished) {
                    [label removeFromSuperview];
        }];
    }];
    
    //如果某个动画执行完毕后，又要回到动画执行前的状态，建议使用transform来做动画
}

-(void)friendsearch
{
    
    
}

-(void)pop
{
   
}

#pragma mark -HWDropdownMenuDelegate
/**
  * 下拉菜单被销毁了
  */

-(void)dropdownMenuDidDismiss:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    //让尖头向下
    titleButton.selected = NO;
}

/**
  * 下拉菜单显示了
  */
-(void)dropdownMenuDidShow:(HWDropdownMenu *)menu
{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    //让尖头向上
    titleButton.selected = YES;
}

/**
  * 标题点击
  */
-(void)titleClick:(UIButton *)titleButton
{
    //1.创建下拉菜单
    HWDropdownMenu *menu =[HWDropdownMenu menu];
    menu.delegate = self;
    
    //2.设置内容
    HWTitleMenuViewController *titleVC = [[HWTitleMenuViewController alloc]init];
    titleVC.view.height = 150;
    titleVC.view.width = 150;
    menu.contentController =titleVC;
    
    //3.显示
    [menu showFrom:titleButton];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
     //如果tableView还没有数据，就直接返回
    if (self.statusFrames.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
    
    CGFloat offsetY = scrollView.contentOffset.y;
    // 当最后一个cell完全显示在眼前时，contentOffset的y值
    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom -
    scrollView.height - self.tableView.tableFooterView.height;
    if (offsetY >= judgeOffsetY) { //最后一个cell完全进入视野范围内
        // 显示footer
        self.tableView.tableFooterView.hidden = NO;
        
        //加载更多的微博数据
        [self loadMoreStatus];
    }
}

/** 
  * 加载更多的微博数据
  */
-(void)loadMoreStatus
{
    // 1.封装请求参数
    HWHomeStatusesParam *param = [HWHomeStatusesParam param];
    // 取出最后面的微博（最新的微博，ID最大的微博）
    HWStatusCellFrame *lastStatusF = [self.statusFrames lastObject];
    HWStatus *lastStatus = lastStatusF.status;
    
    if (lastStatus) {
        //若指定此参数，则返回ID小于或者等于max_id 的微博，默认为0
        //id这种数据一般都是比较大的，一般转成整数的话，最好都是long long类型
        //long long maxId = lastStatus.idstr.longLongValue - 1;
        param.max_id = @(lastStatus.ID);
    }
    
    //3.发送GET请求
    [HWStatusTool homeStatusesWithParam:param success:^(NSArray *statues) {
        //将 “微博字典” 数组 转化为 ”微博模型“数组
        //NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        //获得最新的微博frame数组
        //将 HWStatus数组 转为 HWStatusFrame数组
        NSArray *newFrames = [self statusFramesWithStatuses:statues];
        
        //将更多的微博数据， 添加到总数组的最后面
        [self.statusFrames addObjectsFromArray:newFrames];
        
        //刷新表格
        [self.tableView reloadData];
        
        //结束刷新（隐藏footer）
        //[self.tableView.footer endRefreshing];
        self.tableView.tableFooterView.hidden = YES;
    } failure:^(NSError *error) {
        HWLog(@"请求失败-%@",error);
        
        // 结束刷新
        //[self.tableView.footer endRefreshing];
        self.tableView.tableFooterView.hidden = YES;
    }];
//    [mgr GET:@"https://api.weibo.com/2/statuses/friends_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
//        //将 “微博字典” 数组 转化为 ”微博模型“数组
//        NSArray *newStatuses = [HWStatus objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
//        
//        //将 HWStatus数组 转为 HWStatusFrame数组
//        NSArray *newFrames = [self statusFramesWithStatuses:newStatuses];
//        
//        //将更多的微博数据， 添加到总数组的最后面
//        [self.statusFrames addObjectsFromArray:newFrames];
//        
//        //刷新表格
//        [self.tableView reloadData];
//        
//        //结束刷新（隐藏footer）
//        self.tableView.tableFooterView.hidden = YES;
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        HWLog(@"请求失败-%@",error);
//        
//        // 结束刷新
//        self.tableView.tableFooterView.hidden = YES;
//    }];
}


#pragma mark -Table view data source 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.statusFrames.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"ID";
    HWStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    //获得cell
    if (cell == nil) {
        cell = [[HWStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    //给cell传递模型数据
    cell.statusCellFrame = self.statusFrames[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusCellFrame *frame  = self.statusFrames[indexPath.row];
    return frame.cellHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HWStatusDetailController *detail =[[HWStatusDetailController alloc] init];
    HWStatusCellFrame *frame = self.statusFrames[indexPath.row];
    detail.status = frame.status;
    [self.navigationController pushViewController:detail animated:YES];
}

@end
