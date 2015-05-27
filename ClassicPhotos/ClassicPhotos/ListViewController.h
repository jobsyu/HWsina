//
//  LIstViewController.h
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/8.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreImage/CoreImage.h>
#import "PhotoRecord.h"
#import "PendingOperations.h"
#import "ImageDownloader.h"
#import "ImageFiltration.h"

#import "AFNetworking.h"

#define kDatasourceURLString @"https://sites.google.com/site/soheilsstudio/tutorials/nsoperationsampleproject/ClassicPhotosDictionary.plist"

@interface ListViewController : UITableViewController<ImageDownloaderDelegate,ImageFiltrationDelegate>

@property (nonatomic,strong) NSMutableArray *photos;

@property (nonatomic,strong) PendingOperations *pendingOperaitons;

@end
