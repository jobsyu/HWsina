//
//  PendingOperations.m
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "PendingOperations.h"

@implementation PendingOperations

@synthesize downloadsInProgress =_downloadsInProgress;
@synthesize downloadQueue = _downloadQueue;

@synthesize filtrationsProgress = _filtrationsProgress;
@synthesize filtrationQueue = _filtrationQueue;


-(NSMutableDictionary*)downloadsInProgress{
    if (!_downloadsInProgress) {
        _downloadsInProgress = [[NSMutableDictionary alloc] init];
    }
    return _downloadsInProgress;
}

-(NSOperationQueue *)downloadQueue{
    if (!_downloadQueue) {
        _downloadQueue = [[NSOperationQueue alloc] init];
        _downloadQueue.name = @"Download Queue";
        _downloadQueue.maxConcurrentOperationCount =1;
    }
    return _downloadQueue;
}



-(NSMutableDictionary *)filtrationsProgress{
    if (!_filtrationsProgress) {
        _filtrationsProgress = [[NSMutableDictionary alloc] init];
    }
    return _filtrationsProgress;
}

-(NSOperationQueue *)filtrationQueue{
    if (!_filtrationQueue) {
        _filtrationQueue = [[NSOperationQueue alloc] init];
        _filtrationQueue.name = @"Image Filtration Queue";
        _filtrationQueue.maxConcurrentOperationCount = 1;
    }
    return _filtrationQueue;
}
@end
