//
//  USAModel.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "USAModel.h"

@implementation USAModel


+(NSMutableArray *)parsingWithJsonData:(NSData *)data{
   
    if(data.length >0){
        NSMutableArray *models = [[NSMutableArray alloc] init];
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil] objectForKey:@"subjects"];
        for (int i=0; i<array.count; i++) {
            NSDictionary *dictionary = array[i];
            USAModel *model = [[USAModel alloc] init];
            [model setValuesForKeysWithDictionary:dictionary[@"subject"]];
            [models addObject:model];
        }
        return models;
    }
    return nil;
}


@end
