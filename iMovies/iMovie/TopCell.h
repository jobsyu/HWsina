//
//  TopCell.h
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TopModel.h"
#import "TopView.h"

@interface TopCell : BaseTableViewCell<TapTopViewDelegate>

__sysclass(NSArray, topArray);

@end
