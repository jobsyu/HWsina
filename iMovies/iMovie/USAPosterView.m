//
//  USAPosterView.m
//  iMovie
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "USAPosterView.h"
#import "SDWebImage/UIImageView+WebCache.h"
#import "UIViewExt.h"
#import "PosterDetailView.h"
#import "UIUtils.h"

#define kItemHeight 35
#define kPosterWidth 260
#define kHeaderScrollHeight 100
#define kHeaderScrollImageViewWith 80

#define kFlagDecelerat @"Decelerat"
#define kFlagDragg @"Dragg"

#define kDownItemWith 30

@implementation USAPosterView{

    UIImageView *_headerItem;
    UIScrollView *_posterView;
    UIScrollView *_headerScrollView;
    UIImageView *_footerImageView;
    UILabel *_titleLabel;
    UIImageView *_downImageView;
    UIImageView *_upImageView;
    UIView *_maskView;
}

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
        self.backgroundColor = [UIColor colorWithPatternImage:
                                [UIImage imageNamed:kMOVIE_TableView_BG]];
        
        [self _initSubView];
    }
    return self;
}

-(void)_initSubView{
    
    //顶部滚动视图按钮
    _headerScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, -kHeaderScrollHeight, kHeaderScrollImageViewWith, kHeaderScrollHeight)];
    _headerScrollView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:
                                                                        kMOVIE_TableView_BG]];
    _headerScrollView.showsHorizontalScrollIndicator = NO;
    _headerScrollView.decelerationRate = 0.2;
    _headerScrollView.delegate = self;
    [self addSubview:_headerScrollView];
    
    //顶部视图
    _headerItem = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kItemHeight)];
    _headerItem.image = [UIImage imageNamed:kMOVIE_INDEX_HOME_IMG];
    _headerItem.userInteractionEnabled =YES;
    
    
    //展示顶部滚动视图按钮 －显示
    _downImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-kDownItemWith/2, 0, kDownItemWith, kDownItemWith)];
    _downImageView.image = [UIImage imageNamed:kMOVIE_DOWN_HOME_IMG];
    _downImageView.userInteractionEnabled =YES;
    _downImageView.hidden = NO;
    UITapGestureRecognizer *tapGesDown = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_downImageView addGestureRecognizer:tapGesDown];
    [_headerItem addSubview:_downImageView];
    
    //展示顶部滚动视图按钮 - 收起
    _upImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH/2-kDownItemWith/2, 0, kDownItemWith, kDownItemWith)];
    _upImageView.image = [UIImage imageNamed:kMOVIE_UP_HOME_IMG];
    _upImageView.userInteractionEnabled = YES;
    _upImageView.hidden= YES;
    UITapGestureRecognizer *tapGesUp = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_upImageView addGestureRecognizer:tapGesUp];
    [_headerItem addSubview:_upImageView];
    
    //创建中间滚动视图
    _posterView = [[UIScrollView alloc] initWithFrame:CGRectMake(30, kItemHeight+45, kPosterWidth, kSCREEN_HEIGHT-49-64-2*(kItemHeight+45))];
    _posterView.showsHorizontalScrollIndicator = NO;
    _posterView.backgroundColor = [UIColor clearColor];
    _posterView.delegate = self;
    [self addSubview:_posterView];
    _footerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,kSCREEN_HEIGHT-49-64-kItemHeight, kSCREEN_WIDTH, kItemHeight)];
    _footerImageView.image = [UIImage imageNamed:kMOVIE_TITLE_HOME_IMG];
    
    //底部电影名称显示
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSCREEN_WIDTH, kItemHeight)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.font = [UIFont boldSystemFontOfSize:20];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [_footerImageView addSubview:_titleLabel];
    [self addSubview:_footerImageView];
    
    //创建遮罩视图
    if (_maskView == nil) {
        _maskView = [[UIView alloc] initWithFrame:self.bounds];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenMaskViewAndHeaderView)];
        [_maskView addGestureRecognizer:tapGes];
        _maskView.hidden = YES;
    }
    [self addSubview:_maskView];
    
    [self addSubview:_headerItem];
    [self addSubview:_headerScrollView];
    
  
}
#pragma mark action
//点击遮罩视图 隐藏遮罩视图和顶部滚动视图
-(void) hiddenMaskViewAndHeaderView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _upImageView.hidden = YES;
        _downImageView.hidden = NO;
        [self _hiddenMaskView];
        _headerItem.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kItemHeight);
        _headerScrollView.frame = CGRectMake(0,-kHeaderScrollHeight ,kSCREEN_WIDTH, kHeaderScrollHeight);
        
    }];
}

-(void)tapAction{
    if(_upImageView.hidden){
        _upImageView.hidden = NO;
        _downImageView.hidden = YES;
        [self _createMaskView];
        [UIView animateWithDuration:0.3 animations:^{
            _headerItem.frame = CGRectMake(0, kHeaderScrollHeight, kSCREEN_WIDTH, kItemHeight);
            _headerScrollView.frame = CGRectMake(0,0 , kSCREEN_WIDTH, kHeaderScrollHeight);
        }];
    }else {
        _upImageView.hidden = YES;
        _downImageView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            [self _hiddenMaskView];
            _headerItem.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kItemHeight);
            _headerScrollView.frame = CGRectMake(0,-kHeaderScrollHeight ,kSCREEN_WIDTH, kHeaderScrollHeight);
        }];
    }
}

-(void)_createMaskView{
    _maskView.backgroundColor = Color(0, 0, 0, 0.7);
    //[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _maskView.hidden = NO;}

-(void)_hiddenMaskView{
    _maskView.backgroundColor = [UIColor clearColor];
    //[UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    _maskView.hidden = YES;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    /*************************************数据加载***************************************/
    
    //显示海报图片，影片，查看影片详情
    float x=0;
    for(int i=0; i<_models.count;i++){
        USAModel *model = _models[i];
        UIImageView *movieView =[[UIImageView alloc] initWithFrame:CGRectMake(120+x, 0, kHeaderScrollImageViewWith, kHeaderScrollHeight)];
        movieView.userInteractionEnabled = YES;
        movieView.tag = i+200;
        NSString *imageUrl = [model.images objectForKey:@"small"];
        [movieView setImageWithURL:[NSURL URLWithString:imageUrl]];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetailView:)];
        [_headerScrollView addSubview:movieView];
        [movieView addGestureRecognizer:tapGes];
        x+=85;
    }
    _headerScrollView.contentSize = CGSizeMake(2*120+x-5, kHeaderScrollHeight);
    
    //海报详情
    _posterView.pagingEnabled = YES;
    _posterView.clipsToBounds =  NO;
    x = 0;
    for (int i=0; i<_models.count; i++) {
        USAModel *model = _models[i];
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10+x, 10,kPosterWidth-20, kSCREEN_HEIGHT-49-64-2*(kItemHeight+45)-20)];
        view.tag = i+10;
        view.backgroundColor = [UIColor clearColor];
        UIImageView *movieImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,kPosterWidth-20,kSCREEN_HEIGHT-49-64-2*(kItemHeight+45)-20)];
        movieImageView.backgroundColor = [UIColor clearColor];
        movieImageView.userInteractionEnabled = YES;
        movieImageView.hidden = NO;
        movieImageView.tag = 100+i;
        NSString *imageUrl = [model.images objectForKey:@"large"];
        [movieImageView setImageWithURL:[NSURL URLWithString:imageUrl]];
        [view addSubview:movieImageView];
        
        PosterDetailView *detailView = [[PosterDetailView alloc] initWithFrame:CGRectMake(0, 0, kPosterWidth-20, kSCREEN_HEIGHT-49-64-2*(kItemHeight+45)-20)];
        detailView.hidden = YES;
        detailView.tag = i+1000;
        detailView.usaModel = model;
        [view addSubview:detailView];
        
        
        
        UITapGestureRecognizer  *tapGes =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDetailInfo:)];
        [view addGestureRecognizer:tapGes];
        [_posterView addSubview:view];
        x+=260;
    }
    _posterView.contentSize = CGSizeMake(x, kSCREEN_HEIGHT-49-64-2*(kItemHeight+45));
    USAModel *model = _models[0];
    _titleLabel.text = model.title;
    
}

-(void)_scrollViewDidEnding:(UIScrollView *)scrollView flag:(NSString *)flag{
    int index = 0;
    USAModel *model = nil;
    if(scrollView == _posterView){
        index = scrollView.contentOffset.x/kPosterWidth;
    }else{
        index = (int)floorf((scrollView.contentOffset.x - 42.5)/(kHeaderScrollImageViewWith+5)+1);
        [scrollView setContentOffset:CGPointMake(index*85, 0) animated:YES];
        [_posterView setContentOffset:CGPointMake(index*260, 0) animated:YES];
    }
    if (index>_models.count-1 || index<0) {
        return;
    }
    model = _models[index];
    _titleLabel.text = model.title;
}

-(void)showDetailView:(UITapGestureRecognizer *)ges{
    UIImageView *movieView = (UIImageView *)ges.view;
    int index = movieView.tag -200;
    CGPoint point = CGPointMake(index*kPosterWidth, 0);
    [_posterView setContentOffset:point animated:YES];
    USAModel *model = _models[index];
    _titleLabel.text = model.title;
    [UIView animateWithDuration:0.3 animations:^{
        _upImageView.hidden = YES;
        _downImageView.hidden = NO;
        [self _hiddenMaskView];
        _headerItem.frame = CGRectMake(0, 0, kSCREEN_WIDTH, kItemHeight);
        _headerScrollView.frame = CGRectMake(0, -kHeaderScrollHeight, kSCREEN_WIDTH, kHeaderScrollHeight);
    } completion:^(BOOL finished){
        [_headerScrollView setContentOffset:CGPointMake(index*85 , 0) animated:YES];
    }];
}

-(void)showDetailInfo:(UITapGestureRecognizer *)ges{
    UIView *view = (UIView *)ges.view;
    UIImageView *movieImage = (UIImageView *)[view viewWithTag:(view.tag-10)+100];
    PosterDetailView *detailview = (PosterDetailView *)[view viewWithTag:(view.tag-10)+1000];
    [UIUtils animationWith:movieImage listView:detailview superView:view];

}

#pragma mark UIScrollView delegate

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //[self ]
    [self _scrollViewDidEnding:scrollView flag:kFlagDragg];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
   [self _scrollViewDidEnding:scrollView flag:kFlagDecelerat];
}

@end
