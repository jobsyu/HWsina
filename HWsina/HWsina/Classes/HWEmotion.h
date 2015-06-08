//
//  HWEmotion.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HWEmotion : NSObject
/** 表情的文字描述 */
@property (nonatomic,copy) NSString *chs;
/** 表情的png图片名 */
@property (nonatomic,copy) NSString *png;
/** emoji表情的16进制编码 */
@property (nonatomic,copy) NSString *code;
@end
