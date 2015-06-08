//
//  HWComposeToolbar.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
     HWComposeToolbarButtonTypeCamera, //拍照
     HWComposeToolbarButtonTypePicture, //相册
     HWComposeToolbarButtonTypeMention, //@
     HWComposeToolbarButtonTypeTrend, // #
     HWComposeToolbarButtonTypeEmotion // 表情
} HWComposeToolbarButtonType;

@class HWComposeToolbar;

@protocol HWComposeToolbarDelegate <NSObject>

@optional
-(void)composeToolbar:(HWComposeToolbar *)toolbar didClickButton:(HWComposeToolbarButtonType)buttonType;
@end

@interface HWComposeToolbar : UIView
@property (nonatomic,weak) id<HWComposeToolbarDelegate> delegate;
/** 是否要显示键盘按钮 */
@property (nonatomic,assign) BOOL showKeyboardButton;
@end
