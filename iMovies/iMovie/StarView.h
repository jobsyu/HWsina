//
//  StarView.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum kStarStyle{
    kSmallStyle = 0,
    kNormalStyle = 1
}kStarStyle;

@interface StarView : UIView{

@private
    UIView *_baseView;
    UILabel *starLabel;
    NSMutableArray *grayStarArray;
    NSMutableArray *yellowStarArray;
}

@property (nonatomic,assign) kStarStyle style;
@property (nonatomic,assign) CGFloat rating;

@end
