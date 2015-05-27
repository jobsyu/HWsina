//
//  LaunchViewController.h
//  iMovie
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LaunchViewControllerDelegate;

@interface LaunchViewController : UIViewController{
    int _count;
    int _maxRow;
    float _height;
}

__delegate(LaunchViewControllerDelegate,delegate);


@end

@protocol LaunchViewControllerDelegate <NSObject>

-(void)showLaunchViewDidEnd;

@end