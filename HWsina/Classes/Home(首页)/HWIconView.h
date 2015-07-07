//
//  HWIconView.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
   kIconTypeSmall,
   kIconTypeDefault,
   kIconTypeBig
} IconType;
@class HWUser;
@interface HWIconView : UIView
@property (nonatomic,strong) HWUser *user;
@property (nonatomic,assign) IconType type;

-(void)setUser:(HWUser *)user type:(IconType)type;

+(CGSize)iconSizeWithType:(IconType)type;
@end
