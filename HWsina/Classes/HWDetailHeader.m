//
//  HWDetailHeader.m
//  HWsina
//
//  Created by qianfeng on 15/6/24.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWDetailHeader.h"
#import "HWStatus.h"

@interface HWDetailHeader()
{
    UIButton *_selectedBtn;
}
@end

@implementation HWDetailHeader

#pragma mark 监听按钮点击
- (IBAction)btnClick:(UIButton *)sender {
    // 控制状态
    _selectedBtn.enabled = YES;
    sender.enabled = NO;
    _selectedBtn = sender;
    
    // 移动三角形指示器
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = _hint.center;
        center.x  = sender.center.x;
        _hint.center = center;
    }];
    
    DetailHeaderBtnType type = (sender==_repost)?kDetailHeaderBtnTypeRepost:kDetailHeaderBtnTypeComment;
    _currentBtnType = type;
    
    // 通知代理
    if ([_delegate respondsToSelector:@selector(detailHeader:btnClick:)]) {
        [_delegate detailHeader:self btnClick:type];
    }
}

+ (id)header
{
    return [[NSBundle mainBundle] loadNibNamed:@"DetailHeader" owner:nil options:nil][0];
}

- (void)awakeFromNib
{
    self.backgroundColor = HWGlobeTableViewBackgroundColor;
    [self btnClick:_comment];
}

//- (void)drawRect:(CGRect)rect
//{
//    UIImage *image = [UIImage resizedImage:@"statusdetail_comment_top_background.png"];
//
//    [image drawInRect:rect];
//}

- (void)setStatus:(HWStatus *)status
{
    _status = status;
    
    [self setBtn:_comment title:@"评论" count:status.comments_count];
    [self setBtn:_repost title:@"转发" count:status.reposts_count];
    [self setBtn:_attitude title:@"赞" count:status.attitudes_count];
}

- (void)setBtn:(UIButton *)btn title:(NSString *)title count:(int)count
{
    if (count >= 10000) { // 上万
        CGFloat final = count / 10000.0;
        title = [NSString stringWithFormat:@"%.1f万 %@", final, title];
        // 替换.0为空串
        title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        [btn setTitle:title forState:UIControlStateNormal];
    } else { // 一万以内
        title = [NSString stringWithFormat:@"%d %@", count, title];
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

@end
