//
//  HWStatus.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWStatus.h"
#import "MJExtension.h"
#import "HWPhoto.h"
@implementation HWStatus

-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super initWithDict:dict]) {
        self.pic_urls = dict[@"pic_urls"];
        NSDictionary *retweet = dict[@"retweeted_status"];
//        NSArray *photos = [HWPhoto objectArrayWithKeyValuesArray:dict[@"pic_urls"]];
//        for (id  item in photos) {
//            if ([item isKindOfClass:[HWPhoto class]]) {
//                HWPhoto *photo = (HWPhoto *)item;
//            }
//        }
        if (retweet) {
            self.retweeted_status = [[HWStatus alloc] initWithDict:retweet];
        }
        self.source = dict[@"source"];
        
        self.reposts_count = [dict[@"reposts_count"] intValue];
        self.comments_count = [dict[@"comments_count"] intValue];
        self.attitudes_count = [dict[@"attitudes_count"] intValue];
    }
    return self;
}

//- (NSDictionary *)objectClassInArray
//{
//    return @{@"pic_urls" :[HWPhoto class]};
//}

// source == <a href="http://app.weibo.com/t/feed/2llosp" rel="nofollow">OPPO_N1mini</a>
-(void)setSource:(NSString *)source
{
    if (source == nil||[source isEqualToString:@""]) return;
    
    //正则表达式 NSRegularExpression
    //截取 NSString
    NSRange range;
    range.location = [source rangeOfString:@">"].location + 1;
    range.length = [source rangeOfString:@"</"].location -range.location;
    _source = [NSString stringWithFormat:@"来自%@",[source substringWithRange:range]];
}

@end
