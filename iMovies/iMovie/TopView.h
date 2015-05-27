//
//  TopView.h
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopModel.h"

@protocol TapTopViewDelegate <NSObject>

-(void)tapTopView:(id)target withID:(NSString *)topId;

@end

@interface TopView : UIView

__class(TopModel, topModel);
__delegate(TapTopViewDelegate, delegate);

@end
