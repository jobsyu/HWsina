//
//  NewsModel.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+(NSMutableArray *)parsingWithJsonData:(NSData *)data{

    if(data.length > 0){
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (int i=0; i<array.count; i++) {
            NSDictionary *dict = array[i];
            NewsModel *model = [[NewsModel alloc] init];
            [model setValuesForKeysWithDictionary:dict];
            [dataArray addObject:model];
        }
        return dataArray;
    }
    return nil;
}

@end
