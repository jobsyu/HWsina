//
//  HWConst.h
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifdef DEBUG //处于开发阶段
#define HWLog(...) NSLog(__VA_ARGS__)
#else //处于发布阶段
#define HWLog(...)
#endif

//RGB颜色
#define HWColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0];
//随机色
#define HWRandomColor HWColor(arc4random_uniform(256),arc4random_uniform(256),arc4random_uniform(256));