//
//  HWEmotionPopView.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWEmotionPopView.h"
#import "HWEmotionButton.h"

@interface HWEmotionPopView()
@property (weak,nonatomic) IBOutlet HWEmotionButton *emotionButton;
@end

@implementation HWEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HWEmotionPopView" owner:nil options:nil] lastObject];
}


-(void)showFrom:(HWEmotionButton *)button
{
    if (button == nil) return;
    
    //给popView传递数据
    self.emotionButton.emotion = button.emotion;
    
    //取得最上面的window
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //计算出被点击的按钮在window中的frame
    CGRect btnFrame =[button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(btnFrame) -self.height; //100
    self.centerX = CGRectGetMidX(btnFrame);
}
@end
