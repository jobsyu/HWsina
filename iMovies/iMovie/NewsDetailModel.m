//
//  NewsDetailModel.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsDetailModel.h"

@implementation NewsDetailModel

+(id)parsingWithJsonDataForModel:(NSData *)data{
    NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NewsDetailModel *model =[[NewsDetailModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    return model;
}

@end
