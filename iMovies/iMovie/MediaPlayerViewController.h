//
//  MediaPlayerViewController.h
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MediaPlayerViewController : BaseViewController

__class(MPMoviePlayerController, player);
__uiclass(UIButton, button);

@end
