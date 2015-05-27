//
//  UIView+Additions.m
//  SinaWeiBo
//
//  Created by qianfeng on 14-10-4.
//  Copyright (c) 2014年 Albert. All rights reserved.
//

#import "UIView+Additions.h"

@implementation UIView (Additions)

//根据第一相应者找到父视图
-(UIViewController *)viewController{

    UIResponder *next = self.nextResponder;
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next !=nil);
    
    return nil;
}

@end
