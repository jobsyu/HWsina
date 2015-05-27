//
//  MoreView.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "MoreView.h"
#import "UIGlobalCommon.h"

#define kPopViewWith 160
#define kPopViewHeight 180

@implementation MoreView{
 
    NSArray *_listArray;
    NSArray *_images;
}


-(id)initWithFrame:(CGRect)frame{
  
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor =Color(0, 0, 0, 0.5);
        _listArray = kMOVIE_MORE_TITLES;
        _images = @[kMOVIE_SEARCH_IMG,kMOVIE_FAV_IMG,kMOVIE_SET_IMG,kMOVIE_PHB_IMG];
        [self _initSubView];
    }
    return self;
}



-(void)_initSubView{
    _popView = [[UIImageView alloc] initWithFrame:CGRectMake(kSCREEN_WIDTH-kPopViewWith-5, kSCREEN_HEIGHT-kPopViewHeight-49-20+6, kPopViewWith, kPopViewHeight)];
    _popView.image = [UIImage imageNamed:kMOVIE_POPVIEW_BG];
    _popView.userInteractionEnabled = YES;
    [self addSubview:_popView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kPopViewWith, kPopViewHeight-7) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.scrollEnabled = NO;
    _tableView.delegate = self;
    _tableView.layer.cornerRadius = 3;
    _tableView.layer.masksToBounds = YES;
    _tableView.dataSource = self;
    
    if(OSVersion()>7){
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [_popView addSubview:_tableView];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if(_popView !=touch.view){
        if ([self.delegate respondsToSelector:@selector(didMoreViewWithTag:)]) {
            [self.delegate didMoreViewWithTag:_index];
        }
    }
}

#pragma mark UITableView delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _listArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    if(indexPath.row == 0){
        cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
        cell.textLabel.text = _listArray[indexPath.row];
    }else if(indexPath.row == 1){
        cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
        cell.textLabel.text = _listArray[indexPath.row];
    }else if(indexPath.row == 2){
        cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
        cell.textLabel.text = _listArray[indexPath.row];
    }else {
        cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
        cell.textLabel.text = _listArray[indexPath.row];
    }
    
    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:KMOVIE_NAVIGATION_BG]];
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor whiteColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.delegate respondsToSelector:@selector(didTableViewCellWithIndex:)]){
        [self.delegate didTableViewCellWithIndex:indexPath.row];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
