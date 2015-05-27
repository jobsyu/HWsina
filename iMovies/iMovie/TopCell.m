//
//  TopCell.m
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopCell.h"
#import "UIView+Additions.h"
#import "MovieTabBarController.h"
#import "DetailViewController.h"

#define kTopViewWith 120

@implementation TopCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self _initSubView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
    }
    return self;
}

#pragma mark init subView
-(void)_initSubView{
    for (int i=0; i<3; i++) {
        TopView *topView = [[TopView alloc] initWithFrame:CGRectMake(10+i*((kSCREEN_WIDTH-20)/3), 5, kSCREEN_WIDTH/3, kTopViewWith)];
        topView.tag = i+2014;
        [self.contentView addSubview:topView];
    }
}


-(void) setTopArray:(NSArray *)topArray{
    
    if (_topArray!=topArray) {
        _topArray = topArray;
        
        for (int i =0;i<3; i++) {
            
            TopView *topView = (TopView *)[self.contentView viewWithTag:i+2014];
            topView.hidden = YES;
            
        }
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    for (int i=0; i<_topArray.count; i++) {
        TopModel *topModel = _topArray[i];
        TopView *topView = (TopView *)[self.contentView viewWithTag:2014+i];
        topView.delegate = self;
        topView.hidden = NO;
        topView.topModel = topModel;
    }
}


-(void)tapTopView:(id)target withID:(NSString *)topId{
    
    DetailViewController *detailVC = [[DetailViewController alloc] init];
    [self.viewController.navigationController pushViewController:detailVC animated:YES];
    MovieTabBarController *tabBarVC = (MovieTabBarController *)self.viewController.tabBarController;
    [tabBarVC hiddenTabBarView:YES];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
