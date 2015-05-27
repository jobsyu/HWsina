//
//  CommentModel.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentModel.h"

@implementation CommentModel

+(NSMutableArray *)parsingWithJsonData:(NSData *)data{
    NSDictionary *dict =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSArray *array = [dict objectForKey:@"list"];
    NSMutableArray *models = [[NSMutableArray alloc] init];
    for (int i=0; i<array.count; i++) {
        CommentModel *model = [[CommentModel alloc] init];
        [model setValuesForKeysWithDictionary:array[i]];
        [models addObject:model];
    }
    return models;
}

@end
