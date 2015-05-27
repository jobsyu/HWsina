//
//  TopTableView.m
//  iMovie
//
//  Created by qianfeng on 15/5/15.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "TopTableView.h"
#import "TopCell.h"

@implementation TopTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.rowHeight = 125;
    }
    return self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TopCell *cell = [self dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        cell = [[TopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.topArray = self.dataArray[indexPath.row];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
}

@end
