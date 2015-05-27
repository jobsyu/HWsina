//
//  ImageFiltration.h
//  ClassicPhotos
//
//  Created by qianfeng on 15/5/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>
#import "PhotoRecord.h"

@protocol ImageFiltrationDelegate;

@interface ImageFiltration : NSOperation

@property (nonatomic,weak) id <ImageFiltrationDelegate> delegate;
@property (nonatomic,readonly,strong) NSIndexPath * indexPathInTableView;
@property (nonatomic,readonly,strong) PhotoRecord * photoRecord;

-(id)initWithPhotoRecord:(PhotoRecord *)record atIndexPath:(NSIndexPath *)indexPath
                delegate:(id<ImageFiltrationDelegate>)theDelegate;
@end

@protocol ImageFiltrationDelegate <NSObject>

-(void)imageFiltrationDidFinish:(ImageFiltration*)filtration;

@end
