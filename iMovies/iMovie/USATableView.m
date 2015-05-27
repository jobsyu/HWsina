//
//  USATableView.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "USATableView.h"

@implementation USATableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:kMOVIE_TableView_BG]];
        self.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        self.rowHeight = 84;
    }
    return self;
}


#pragma mark UITableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    USACell *cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        cell = [[USACell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
    }
    cell.usaModel = self.dataArray[indexPath.row];
    return cell;
}


@end
