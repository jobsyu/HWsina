//
//  TopModel.m
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopModel.h"

@implementation TopModel

+(NSMutableArray *)parsingWithJsonData:(NSData *)data{
    if(data.length > 0){
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"entries"];
        
        for (int i=0; i < array.count; i++) {
            TopModel *topModel = [[TopModel alloc] init];
            NSDictionary *dict = (NSDictionary *)array[i];
            [topModel setValuesForKeysWithDictionary:dict];
            [dataArray addObject:topModel];
        }
        
        return dataArray;
    }
    return nil;
}

@end
