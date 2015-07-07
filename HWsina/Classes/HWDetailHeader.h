//
//  HWDetailHeader.h
//  HWsina
//
//  Created by qianfeng on 15/6/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HWStatus,HWDetailHeader;

typedef enum {
    kDetailHeaderBtnTypeRepost, //转发
    kDetailHeaderBtnTypeComment, //评论
} DetailHeaderBtnType;


@protocol HWDetailHeaderDelegate <NSObject>

@optional
-(void)detailHeader:(HWDetailHeader *)header btnClick:(DetailHeaderBtnType)index;

@end

@interface HWDetailHeader : UIView

@property (weak,nonatomic) IBOutlet UIButton *attitude;
@property (weak,nonatomic) IBOutlet UIButton *repost;
@property (weak,nonatomic) IBOutlet UIButton *comment;
@property (weak,nonatomic) IBOutlet UIImageView *hint;

-(IBAction)btnClick:(UIButton *)sender;
+(id)header;

@property (nonatomic,strong) HWStatus *status;
@property (nonatomic,weak) id<HWDetailHeaderDelegate> delegate;
@property (nonatomic,assign,readonly) DetailHeaderBtnType currentBtnType;;
@end
