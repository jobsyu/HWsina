//
//  UIUtils.m
//  iMovie
//
//  Created by qianfeng on 15/5/13.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "UIUtils.h"
#import "Switch3DTransition.h"
#import "HMGLTransitionManager.h"
#import "ClothTransition.h"

@implementation UIUtils


//计算字体占据空间的大小
//不同的ios版本,调用不同的方法,实现相同的功能
+(CGSize)sizeOfStr:(NSString *)str andFont:(UIFont *)font andMaxSize:(CGSize)size andLineBreakMode:(NSLineBreakMode)mode
{
    CGSize s;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue]>=7.0) {
        NSDictionary *dic=@{NSFontAttributeName:font};
        NSMutableDictionary  *mdic=[NSMutableDictionary dictionary];
        [mdic setObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
        [mdic setObject:font forKey:NSFontAttributeName];
        s = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:mdic context:nil].size;
    }
    else
    {
        s=[str sizeWithFont:font constrainedToSize:size lineBreakMode:mode];
    }
    return s;
}

+(void)animationWithButton:(UIView *)posterView listView:(UIView *)listView superView:(UIView *)superView{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [superView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    if(posterView.hidden){
        posterView.hidden = NO;
        listView.hidden = YES;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:superView cache:YES];
    }
    else{
        posterView.hidden = YES;
        listView.hidden = NO;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:superView cache:YES];
    }
    [UIView commitAnimations];
}

+(void)animationWith:(UIView *)posterView listView:(UIView *)listView superView:(UIView *)superView{
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:0.5];
//    [superView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//    if(posterView.hidden){
//        posterView.hidden = NO;
//        listView.hidden = YES;
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:superView cache:YES];
//    }
//    else{
//        posterView.hidden = YES;
//        listView.hidden = NO;
//        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:superView cache:YES];
//    }
//    [UIView commitAnimations];
    Switch3DTransition *switch3DTransition = [[Switch3DTransition alloc] init];
    [[HMGLTransitionManager sharedTransitionManager] setTransition:switch3DTransition];
    [[HMGLTransitionManager sharedTransitionManager] beginTransition:superView];
    [superView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    if(posterView.hidden){
        posterView.hidden = NO;
        listView.hidden = YES;
    }
    else{
        posterView.hidden = YES;
        listView.hidden = NO;
    }
    [[HMGLTransitionManager sharedTransitionManager] commitTransition];
}

@end
