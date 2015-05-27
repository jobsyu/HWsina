//
//  PendingOperations.h
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PendingOperations : NSObject

@property (nonatomic,strong) NSMutableDictionary * downloadsInProgress;
@property (nonatomic,strong) NSOperationQueue *downloadQueue;

@property (nonatomic,strong) NSMutableDictionary * filtrationsProgress;
@property (nonatomic,strong) NSOperationQueue *filtrationQueue;

@end
