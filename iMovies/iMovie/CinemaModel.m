//
//  CinemaModel.m
//  iMovie
//
//  Created by qianfeng on 15/5/16.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CinemaModel.h"

@implementation CinemaModel

+(NSMutableArray *)parsingWithJsonData:(NSData *)data{

    if (data.length >0) {
        NSMutableArray *dataArray = [[NSMutableArray alloc] init];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        for (int i=0; i<array.count; i++) {
            CinemaModel *model =[[CinemaModel alloc] init];
            NSDictionary *dict = (NSDictionary*)array[i];
            [model setValuesForKeysWithDictionary:dict];
            [dataArray addObject:model];
        }
        return dataArray;
    }
    return nil;
}


//key:Property value:Json key
-(id)mapAttributes{
    NSDictionary *mapDic =@{@"id": @"id",@"title": @"title",@"image": @"image",@"releaseDate": @"releaseDate",@"type": @"type",@"director": @"director",@"wantedCount": @"wantedCount"};
    return mapDic;
}
@end
