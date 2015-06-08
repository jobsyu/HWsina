//
//  UITextView+Extension.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)

-(void)insertAttributedText:(NSAttributedString *)text;
-(void)insertAttributedText:(NSAttributedString *)text settingBlock:(void(^)
   (NSMutableAttributedString *attributedText))settingBlock;





@end
