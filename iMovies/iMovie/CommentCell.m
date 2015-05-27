//
//  CommentCell.m
//  iMovie
//
//  Created by qianfeng on 15/5/14.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "CommentCell.h"
#import "UIImageView+WebCache.h"
#import "UIUtils.h"

@implementation CommentCell{
    UIImageView *_userImage;
    UILabel *_nickNameLabel;
    UILabel *_ratingLabel;
    UILabel *_contentLabel;
    UIImageView *_bgView;
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self _initSubView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

-(void)_initSubView{
    _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 30, 30)];
    [self.contentView addSubview:_userImage];
    
    _bgView = [[UIImageView alloc] initWithFrame:CGRectMake(40+20, 5, self.contentView.frame.size.width-30-25-20, 60)];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.cornerRadius = 4;
    _bgView.layer.masksToBounds = YES;
    [self.contentView addSubview:_bgView];
    
    _nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, (self.contentView.frame.size.width-30-25-20)/2, 20)];
    _nickNameLabel.textColor = [UIColor greenColor];
    _nickNameLabel.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:_nickNameLabel];
    
    _ratingLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width-30-25-20)/2+60, 0, (self.contentView.frame.size.width-30-25-20)/2-60, 20)];
    _ratingLabel.textColor = [UIColor grayColor];
    _ratingLabel.font = [UIFont systemFontOfSize:14];
    [_bgView addSubview:_ratingLabel];
    
    _contentLabel =[[UILabel alloc] init];
    _contentLabel.textColor = [UIColor blackColor];
    _contentLabel.font = [UIFont boldSystemFontOfSize:13];
    _contentLabel.numberOfLines = 0;
    [_bgView addSubview:_contentLabel];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [_userImage setImageWithURL:[NSURL URLWithString:_model.userImage] placeholderImage:[UIImage imageNamed:kMOVIEW_USER_DEFAULT_IMG]];
    _nickNameLabel.text = _model.nickname;
    _ratingLabel.text = _model.rating;
    
    CGSize size =[UIUtils sizeOfStr:_model.content  andFont:[UIFont boldSystemFontOfSize:13] andMaxSize:CGSizeMake(self.contentView.frame.size.width-30-25-40, 20000) andLineBreakMode:NSLineBreakByWordWrapping];
    _contentLabel.text = _model.content;
    _contentLabel.frame = CGRectMake(0, 20, self.contentView.frame.size.width-30-25-40, size.height+5);
    //_bgView.height = _contentLabel.height+10+_nickNameLabel.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
