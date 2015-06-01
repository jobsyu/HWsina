//
//  HWDropdownMenu.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWDropdownMenu;

@protocol HWDropdownMenuDelegate <NSObject>

@optional
- (void)dropdownMenuDidDismiss:(HWDropdownMenu *)menu;
- (void)dropdownMenuDidShow:(HWDropdownMenu *)menu;
@end

@interface HWDropdownMenu : UIView
@property (nonatomic,weak) id<HWDropdownMenuDelegate> delegate;

+ (instancetype)menu;

/**
  * 显示
  */
-(void)showFrom:(UIView *)from;

/**
 *  销毁
 */
-(void)dismiss;

/**
 * 内容
 */
@property (nonatomic,strong) UIView *content;

/**
 * 内容控制器
 */
@property (nonatomic,strong) UIViewController *contentController;
@end
