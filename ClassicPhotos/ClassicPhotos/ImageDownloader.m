//
//  ImageDownloader.m
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ImageDownloader.h"

@interface ImageDownloader()
@property (nonatomic,readwrite,strong) NSIndexPath * indexPathInTableView;
@property (nonatomic,readwrite,strong) PhotoRecord *photoRecord;
@end

@implementation ImageDownloader

@synthesize delegate = _delegate;
@synthesize indexPathInTableView = _indexPathInTableView;
@synthesize photoRecord = _photoRecord;

#pragma mark -
#pragma mark - Life Cycle

-(id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath delegate:(id<ImageDownloaderDelegate>)theDelegate
{
    if (self = [super init]) {
        self.delegate = theDelegate;
        self.indexPathInTableView = indexPath;
        self.photoRecord = record;
    }
    return self;
}

#pragma mark -
#pragma mark - Downloading image

-(void)main{
    @autoreleasepool {
        if(self.isCancelled)
            return;
        
        NSData *imageData = [NSData dataWithContentsOfURL:self.photoRecord.URL];
        
        if(self.isCancelled){
            imageData = nil;
            return;
        }
        
        if(imageData){
            UIImage *downloadimage = [UIImage imageWithData:imageData];
            self.photoRecord.image = downloadimage;
        }
        else{
            self.photoRecord.image = nil;
        }
        
        imageData =nil;
        
        if(self.isCancelled){
            return;
        }
        
        [(NSObject *)self.delegate performSelectorOnMainThread:@selector(imageDownloaderDidFinish:) withObject:self waitUntilDone:NO];
    }
}
@end
