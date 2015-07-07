//
//  HWIconView.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "HWHttpTool.h"

@interface HWIconView()
@property (nonatomic,weak) UIImageView *icon; //头像图标
@property (nonatomic,weak) UIImageView *vertify; //认证图标

@property (nonatomic,weak) NSString *placehoder; //占位图片
@end


@implementation HWIconView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.用户头像图片
        UIImageView *icon = [[UIImageView alloc] init];
        [self addSubview:icon];
         self.icon = icon;
        
        //2.右下角的认证图标
        UIImageView *vertify = [[UIImageView alloc] init];
        [self addSubview:vertify];
        self.vertify = vertify;
    }
    return self;
}

#pragma mark 同时设置头像的用户和类型
-(void)setUser:(HWUser *)user type:(IconType)type
{
    self.type = type;
    self.user = user;
}

#pragma mark 设置模型数据
- (void)setUser:(HWUser *)user
{
    _user = user;
    
    // 1.下载图
//    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //[self sd_]
    [HWHttpTool downloadImage:user.profile_image_url place:[UIImage imageNamed:self.placehoder] imageView:self.icon];
    
    
    // 2.设置添加V图片
    NSString *verifiedIcon = nil;
    switch (user.verified_type) {
        case HWUSerVerifiedTypeNone: //没有认证
            self.vertify.hidden = YES;
            break;
        case HWUSerVerifiedDaren: //微博达人
            verifiedIcon = @"avatar_grassroot.png";
            break;
        case HWUSerVerifiedPersonal: //个人
            verifiedIcon = @"avatar_vip.png";
            break;
        default: //企业认证
            verifiedIcon = @"avatar_enterprise_vip.png";
            break;

    }
    
    // 3.如果有认证，显示图标
    if (verifiedIcon) {
        self.vertify.hidden = NO;
        self.vertify.image = [UIImage imageNamed:verifiedIcon];
    }
}


#pragma mark 设置图标的类型
 -(void)setType:(IconType)type
{
    _type = type;
    
    //1.判断类型
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall:
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            self.placehoder = @"avatar_default_small.png";
            break;
            
        case kIconTypeDefault:
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            self.placehoder = @"avatar_default.png";
            break;
        
        case kIconTypeBig:
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            self.placehoder = @"avatar_default_big.png";
            break;
    }
    
    //2.设置frame
    _icon.frame = (CGRect){CGPointZero,iconSize};
    _vertify.bounds = CGRectMake(0, 0, kVertifyW, kVertifyH);
    _vertify.center = CGPointMake(iconSize.width, iconSize.height);
    
    // 3.自己的宽高
    CGFloat width = iconSize.width + kVertifyW * 0.5;
    CGFloat height = iconSize.height + kVertifyH * 0.5;
    self.bounds = CGRectMake(0, 0, width, height);
}

+ (CGSize)iconSizeWithType:(IconType)type
{
    CGSize iconSize;
    switch (type) {
        case kIconTypeSmall:  //小图标
            iconSize = CGSizeMake(kIconSmallW, kIconSmallH);
            break;
        
        case kIconTypeDefault: //中图标
            iconSize = CGSizeMake(kIconDefaultW, kIconDefaultH);
            break;
            
        case kIconTypeBig: //大图标
            iconSize = CGSizeMake(kIconBigW, kIconBigH);
            break;
    }
    CGFloat width = iconSize.width + kVertifyW * 0.5;
    CGFloat height = iconSize.height + kVertifyH * 0.5;
    return CGSizeMake(width, height);
}

@end
