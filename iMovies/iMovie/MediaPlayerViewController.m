//
//  MediaPlayerViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MediaPlayerViewController.h"



@interface MediaPlayerViewController ()

@end

@implementation MediaPlayerViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //实例化视频播放器
    
    NSString *urlStr = [[NSBundle mainBundle] pathForResource:@"123" ofType:@"mp4"];
    NSLog(@"%@",urlStr);
    
    NSURL *url = [NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"];
    // Do any additional setup after loading the view.
    
    //视频播放是流媒体的播放模式，所谓流媒体就是把视频数据像流水一样，变加载，变播放。
    //    //提示：如果url中包含中文，需要添加百分号。
    //    NSString *urlString = @"http:www.xxx.com/video/xxx.mp4";
    //    NSURL *url = [NSURL URLWithString:[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    
    self.player = [[MPMoviePlayerController alloc] initWithContentURL:url];
    self.player.movieSourceType = MPMovieSourceTypeFile;
    
    //1设置播放器的大小
    [self.player.view setFrame:CGRectMake(0, 0, 320, 180)];
    self.player.view.backgroundColor = [UIColor grayColor];
    
    //2将播放器视图添加到根视图
    [self.view addSubview:self.player.view];
    
    //4播放
    [self.player play];
    
    //1 监听播放状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(stateChange) name:MPMusicPlayerControllerPlaybackStateDidChangeNotification object:nil];
    
    //2 监听播放完成
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(finishedPlay) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
    //3视频截图
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(caputerImage:) name:MPMoviePlayerThumbnailImageRequestDidFinishNotification object:nil];
    
    //4退出全屏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(exitFullScreen) name:MPMoviePlayerDidExitFullscreenNotification object:nil];
    
    
    //异步视频截图，可以在attimes指定一个或者多个时间
    [self.player requestThumbnailImagesAtTimes:@[@10.0f,@20.0f] timeOption:MPMovieTimeOptionNearestKeyFrame];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(100, 200, 120, 40);
    _button.backgroundColor = [UIColor lightGrayColor];
    [_button setTitle:@"播放" forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(playerAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
}

-(void)playerAction{
    if([_button.currentTitle isEqualToString:@"播放"]){
        [self.player play];
        [_button setTitle:@"暂停" forState:UIControlStateNormal];
        
    }else {
        [_button setTitle:@"播放" forState:UIControlStateNormal];
        [self.player stop];
    }
}

#pragma mark 退出全屏
-(void)exitFullScreen{
    NSLog(@"退出全屏");
}

#pragma mark -播放器事件监听
#pragma mark 视频截图 这个方法是异步方法
-(void)caputerImage:(NSNotification *)notification{
    NSLog(@"截图 %@",notification);
    UIImage *image = notification.userInfo[@"MPMoviePlayerThumbnailImageKey"];
}


#pragma mark 播放器事件监听
#pragma mark 播放完成
-(void)finishedPlay{
    NSLog(@"播放完成");
}

#pragma mark 播放器视频的监听
#pragma mark 播放状态变化

-(void)stateChange{
    switch (self.player.playbackState) {
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case MPMoviePlaybackStatePlaying:
            [self.player setFullscreen:NO animated:YES];
            NSLog(@"播放");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止");
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
