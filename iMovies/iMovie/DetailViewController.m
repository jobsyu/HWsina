//
//  DetailViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "DetailViewController.h"
#import "MovieTabBarController.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "CommentModel.h"
#import "UIUtils.h"
#import "MediaPlayerViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self= [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
        UIBarButtonItem *item= [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
        self.navigationItem.leftBarButtonItem = item;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _loadData];
    [self _initSubView];
    [self _refreshUI];
    
    // Do any additional setup after loading the view.
}

#pragma mark action

-(void)backAction:(UIBarButtonItem *)item{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadView{
    [super loadView];
    UIScrollView *view = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    view.userInteractionEnabled = YES;
    view.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.view = view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count == 1) {
        MovieTabBarController *tabBarVC = (MovieTabBarController *)self.tabBarController;
        [tabBarVC hiddenTabBarView:NO];
    }
}
#pragma mark init UI
-(void) _initSubView{
    float height = [self _movieDetailInfoView];
    height = [self _buttonView:height]+height;
    height = [self _tableViewInfoView:height] +height;
    height = [self _loadCommentTableView:height] +height;
    UIScrollView *view = (UIScrollView *)self.view;
    view.contentSize = CGSizeMake(view.frame.size.width, height+30);
}

-(float) _movieDetailInfoView{
   UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 10, kSCREEN_WIDTH-20, 140)];
    view.tag = 2100;
    
    UIImageView *movieImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kMovieImageViewWith, kMovieImageViewHeight)];
    movieImgView.tag = 2101;
    movieImgView.layer.cornerRadius = 2;
    movieImgView.layer.masksToBounds = YES;
    [view addSubview:movieImgView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMovieImageViewWith+10, 0, kSCREEN_WIDTH-20 - kMovieImageViewWith-10, 20)];
    titleLabel.tag = 2102;
    titleLabel.font =  [UIFont boldSystemFontOfSize:18];
    titleLabel.textColor = [UIColor whiteColor];
    [view addSubview:titleLabel];
    
    UILabel *directorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMovieImageViewWith+10, 20+10, kSCREEN_WIDTH-20 - kMovieImageViewWith-10, 20)];
    directorLabel.tag = 2103;
    directorLabel.font = [UIFont boldSystemFontOfSize:15];
    directorLabel.textColor = [UIColor grayColor];
    [view addSubview:directorLabel];
    
    UILabel *actorLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMovieImageViewWith+10, 50+10, kSCREEN_WIDTH-20 - kMovieImageViewWith-10, 20)];
    actorLabel.tag = 2104;
    actorLabel.font = [UIFont boldSystemFontOfSize:15];
    actorLabel.textColor = [UIColor grayColor];
    [view addSubview:actorLabel];
    
    UILabel *typeLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMovieImageViewWith+10, 80+10, kSCREEN_WIDTH-20 - kMovieImageViewWith-10, 20)];
    typeLabel.tag = 2105;
    typeLabel.font = [UIFont boldSystemFontOfSize:15];
    typeLabel.textColor = [UIColor grayColor];
    [view addSubview:typeLabel];
    
    UILabel *releaseLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMovieImageViewWith+10,  110+10, kSCREEN_WIDTH-20 - kMovieImageViewWith-10, 20)];
    releaseLabel.tag = 2106;
    releaseLabel.font = [UIFont boldSystemFontOfSize:15];
    releaseLabel.textColor = [UIColor grayColor];
    [view addSubview:releaseLabel];
    
    [self.view addSubview:view];
    return 140+10;

}

-(float)_buttonView:(float) height{
    UIView *view =[[UIView alloc] initWithFrame:CGRectMake(30, height+10, kSCREEN_WIDTH-60, 40)];
    view.tag = 2200;
    
    UIButton *xkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [xkBtn setBackgroundImage:[UIImage imageNamed:kMOVIEW_XK_IMG] forState:UIControlStateNormal];
    [xkBtn setBackgroundImage:[UIImage imageNamed:kMOVIEW_XK_ON_IMG] forState:UIControlStateHighlighted];
    xkBtn.frame = CGRectMake(0, 0, (kSCREEN_WIDTH-60)/2, 40);
    xkBtn.tag = 2201;
    [xkBtn setTitle:@"想看" forState:UIControlStateNormal];
    [xkBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:xkBtn];
    
    UIButton *pfBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [pfBtn setBackgroundImage:[UIImage imageNamed:kMOVIEW_PF_IMG] forState:UIControlStateNormal];
    [pfBtn setBackgroundImage:[UIImage imageNamed:kMOVIEW_PF_ON_IMG] forState:UIControlStateHighlighted];
    pfBtn.frame = CGRectMake((kSCREEN_WIDTH-60)/2, 0, (kSCREEN_WIDTH-60)/2, 40);
    pfBtn.tag = 2202;
    [pfBtn setTitle:@"评分" forState:UIControlStateNormal];
    [pfBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [view addSubview:pfBtn];
    
    [self.view addSubview:view];
    return 40+10;
    
}


-(float)_tableViewInfoView:(float)height{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(10, height+10, kSCREEN_WIDTH-20, 248) style:UITableViewStylePlain];
    tableView.dataSource =self;
    tableView.delegate = self;
    tableView.scrollEnabled = NO;
    tableView.layer.cornerRadius = 5;
    tableView.layer.masksToBounds= YES;
    tableView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:tableView];
    return 248+10;
}

-(float) _loadCommentTableView:(float)height{
    _commentTableView = [[CommentTableView alloc] init];
    _commentTableView.dataArray = _commentList;
    _commentTableView.scrollEnabled = NO;
    [_commentTableView setSeparatorInset:UIEdgeInsetsZero];
    [self.view addSubview:_commentTableView];
    int h =0;
    for (int i=0; i<_commentList.count; i++) {
        CommentModel *model = _commentList[i];
        CGSize size =[UIUtils sizeOfStr:model.content  andFont:[UIFont boldSystemFontOfSize:13] andMaxSize:CGSizeMake(kSCREEN_WIDTH-75, 20000) andLineBreakMode:NSLineBreakByWordWrapping];
        h+=size.height+40+10;
    }
    _commentTableView.frame = CGRectMake(0, height+30, kSCREEN_WIDTH, h+40);
    return h+40;
}

#pragma merk load Data
-(void)_loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"movie_detail" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    _model = [NewsDetailModel parsingWithJsonDataForModel:data];
    
    NSString *cpath = [[NSBundle mainBundle] pathForResource:@"movie_comment" ofType:@"json"];
    NSData *cdata = [NSData dataWithContentsOfFile:cpath];
    _commentList = [CommentModel parsingWithJsonData:cdata];
}

-(void)_refreshUI{
    UIView *movieDeView = (UIView *)[self.view viewWithTag:2100];
    UIImageView *movieImgView = (UIImageView *)[movieDeView viewWithTag:2101];
    [movieImgView setImageWithURL:[NSURL URLWithString:_model.image] placeholderImage:[UIImage imageNamed:kMOVIE_DEFUALT_BG]];
    UILabel *tiltleLabel = (UILabel *)[movieDeView viewWithTag:2102];
    tiltleLabel.text = _model.titleCn;
    
    UILabel *directorLabel = (UILabel *)[movieDeView viewWithTag:2103];
    directorLabel.text = [_model.directors componentsJoinedByString:@","];
    
    UILabel *actorLabel = (UILabel *)[movieDeView viewWithTag:2104];
    actorLabel.text = [_model.type componentsJoinedByString:@","];
    
    UILabel *typeLabel = (UILabel *)[movieDeView viewWithTag:2105];
    typeLabel.text = [_model.type componentsJoinedByString:@","];
    
    UILabel *releaseLabel = (UILabel *)[movieDeView viewWithTag:2106];
    NSString *releaseStr = [NSString stringWithFormat:@"%@ %@",[_model.releases objectForKey:@"location"],[_model.releases objectForKey:@"date"]];
    releaseLabel.text = releaseStr;
}

#pragma mark UITableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row == 0){
        return 80;
    } else if (indexPath.row == 1){
        return 44;
    } else if (indexPath.row == 2){
        return 44;
    } else{
        return 80;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.row == 0){
        NSArray *images = _model.images;
        for (int i=0; i<images.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(60+8)+10, 10, 60, 60)];
            [imageView setImageWithURL:[NSURL URLWithString:images[i]] placeholderImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
            [cell.contentView addSubview:imageView];
        }
        
    }else if (indexPath.row == 1){
        cell.textLabel.text = _model.content;
    }else if (indexPath.row == 2){
        cell.textLabel.text = [NSString stringWithFormat:@"演员表: %@",[_model.actors componentsJoinedByString:@","]];
    }else {
        NSArray *images  = _model.videos;
        for (int i=0; i<images.count; i++) {
            NSDictionary *dict = images[i];
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i*(80+11)+10, 10, 80, 60)];
            [imageView setImageWithURL:[NSURL URLWithString:[dict objectForKey:@"image"]] placeholderImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
            [cell.contentView addSubview:imageView];
        }
    }
    cell.textLabel.font = [UIFont boldSystemFontOfSize:17];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MediaPlayerViewController *mediaPlayerVC =[[MediaPlayerViewController alloc] init];
    [self.navigationController pushViewController:mediaPlayerVC animated:YES];
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
