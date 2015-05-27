//
//  NewsHeaderView.h
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"

@protocol TapHeaderImageViewDelegate <NSObject>

@optional
-(void)tapNewsHeaderImageView:(id)target withID:(long)newsId;

@end

@interface NewsHeaderView : UIView

__class(NewsModel, newsModel);
__delegate(TapHeaderImageViewDelegate, delegate);

@end
