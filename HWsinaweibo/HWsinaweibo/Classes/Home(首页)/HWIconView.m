//
//  HWIconView.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/2.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWIconView.h"
#import "HWUser.h"
#import "UIImageView+WebCache.h"

@interface HWIconView()
@property (nonatomic,weak) UIImageView *verifiedView;
@end


@implementation HWIconView

-(UIImageView *)verifiedView
{
    if (!_verifiedView) {
        UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setUser:(HWUser *)user
{
    _user = user;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 2.设置添加V图片
    switch (user.verified_type) {
        case HWUSerVerifiedPersonal: //个人认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
        case HWUSerVerifiedOrgEnterprice:
        case HWUSerVerifiedOrgMedia:
        case HWUSerVerifiedOrgWebsite: //官方认证
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
        case HWUSerVerifiedDaren: //微博达人
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
        default:
            self.verifiedView.hidden = YES; //当作没有认证
            break;
    }
}

@end
