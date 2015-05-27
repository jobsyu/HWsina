//
//  MovieTabBarController.h
//  iMovie
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoreView.h"

@interface MovieTabBarController : UITabBarController<MoreViewDelegate>{
    MoreView *_moreView;
}

__uiclass(UIView, tabBarView);

-(void)hiddenTabBarView:(BOOL)isHidden;

@end
