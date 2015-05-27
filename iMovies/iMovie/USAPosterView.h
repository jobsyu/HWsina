//
//  USAPosterView.h
//  iMovie
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "USAModel.h"

@protocol DownPosterDelegate <NSObject>

@optional
-(void)DownPosterView:(id)target;

@end

@interface USAPosterView : UIView<UIScrollViewDelegate>

__class(USAModel, usaModel);
__sysclass(NSArray, models);
__delegate(DownPosterDelegate, delegate);
@property (nonatomic,copy) void(^downPosterlock)(void);
@end
