//
//  BaseModel.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

//+(id)

+(NSMutableArray *)parsingWithJsonData:(NSData *)data;
+(id)parsingWithJsonDataForModel:(NSData *)data;
-(void)setModelData:(NSDictionary *)json;

@end
