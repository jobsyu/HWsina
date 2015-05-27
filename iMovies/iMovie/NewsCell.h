//
//  NewsCell.h
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "NewsModel.h"

typedef enum  kNewsType{
    
    kWordType = 0,
    kImageType = 1,
    kMovieType = 2
    
}kNewsType;

@interface NewsCell : BaseTableViewCell

__class(NewsModel, newsmodel);

@end
