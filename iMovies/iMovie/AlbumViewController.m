//
//  AlbumViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AlbumViewController.h"
#import "UIGlobalCommon.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "MovieTabBarController.h"


#define kHeaderViewHeight 44
#define kTitleLabelHeight 49

@interface AlbumViewController ()

@end

@implementation AlbumViewController{
    
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UIImageView *_headerView;
    UIScrollView *_contentView;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.backgroundColor = [UIColor blackColor];
        if (OSVersion() < 7) {
            self.hidesBottomBarWhenPushed = YES;
        }
    }
    return self;
}

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count == 2) {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.viewControllers.count == 1) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        MovieTabBarController *tabBarVC = (MovieTabBarController *)self.tabBarController;
        [tabBarVC hiddenTabBarView:NO];
    }
    
}

-(void) hiddenHeaderViewAndFooterLabel{
    if (_headerView.hidden) {
        
        [UIView animateWithDuration:0.7 animations:^{
            _headerView.hidden = NO;
            _titleLabel.hidden = NO;
            _headerView.alpha = 1;
            _titleLabel.alpha = 1;
        }];
    }else{
        
        [UIView animateWithDuration:0.7 animations:^{
            _headerView.alpha = 0;
            _headerView.alpha = 0;
        } completion:^(BOOL finished){
            _headerView.hidden = YES;
            _titleLabel.hidden = YES;
        }];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _initSubView];
    [self loadData];
    // Do any additional setup after loading the view.
}


#pragma mark init UI
-(void) _initSubView{
    
    [self createNavigationBar];
    [self loadImageView];
    [self loadFooterView];
    
}


-(void)createNavigationBar{
    _headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, kSCREEN_WIDTH, kHeaderViewHeight)];
    _headerView.image = [UIImage imageNamed:KMOVIE_NAVIGATION_BG];
    _headerView.userInteractionEnabled = YES;
    UILabel *tLabel = [[UILabel alloc] initWithFrame:_headerView.bounds];
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.font = [UIFont boldSystemFontOfSize:18];
    tLabel.textColor = [UIColor whiteColor];
    tLabel.text = @"电影图片";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"backItem"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    button.frame =CGRectMake(0,0,kHeaderViewHeight,kHeaderViewHeight);
    [_headerView addSubview:button];
    [_headerView addSubview:tLabel];
    [self.view addSubview:_headerView];
}


-(void)loadImageView{
   _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,kHeaderViewHeight+20, kSCREEN_WIDTH, kSCREEN_HEIGHT-kHeaderViewHeight-20)];
    _contentView.backgroundColor = [UIColor clearColor];
    _contentView.pagingEnabled = YES;
    _contentView.userInteractionEnabled =YES;
    _contentView.showsHorizontalScrollIndicator = NO;
    _contentView.delegate = self;
    [self.view addSubview:_contentView];
}

-(void)loadFooterView{
   _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kSCREEN_HEIGHT-kTitleLabelHeight, kSCREEN_WIDTH, kTitleLabelHeight)];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:15];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = Color(0, 0, 0, 0.7);
    [self.view addSubview:_titleLabel];
}


#pragma  mark actions
-(void) backAction:(UIButton *)btn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark load data
-(void)loadData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news_detail_images" ofType:@"json"];
    NSData *data =[NSData dataWithContentsOfFile:path];
    _models = [[NSMutableArray alloc] init];
    _models = [AlbumModel parsingWithJsonData:data];
    
    _contentView.contentSize = CGSizeMake(kSCREEN_WIDTH *_models.count, _contentView.height);
    
    for (int i=0; i<_models.count; i++) {
        AlbumModel *model = _models[i];
        AlbumView *albumView = [[AlbumView alloc] initWithFrame:CGRectMake(i*kSCREEN_WIDTH, 0, _contentView.width, _contentView.height)];
        albumView.tag = 2014 +i;
        albumView.delegate = self;
        albumView.imgUrl = model.url1;
        [_contentView addSubview:albumView];
        if (i == 0) {
            _titleLabel.text =model.title;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

static int _lastIndex = 0;
#pragma mark UIScrollView delegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int index = scrollView.contentOffset.x/kSCREEN_WIDTH;
    if(index <0 || index >(_models.count-1)){
        return;
    }
    
    AlbumModel *model = _models[index];
    _titleLabel.text = model.title;
    
    AlbumView *albumView = (AlbumView *)[_contentView viewWithTag:2014+_lastIndex];
    if (albumView.scrollview.zoomScale >1 && _lastIndex != index) {
        [albumView.scrollview setZoomScale:1 animated:YES];
    }
    
    _lastIndex = index;
}


#pragma mark AlbumView delegate
-(void) didAlbumView{
    
    [self hiddenHeaderViewAndFooterLabel];
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
