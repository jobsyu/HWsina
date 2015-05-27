//
//  NewsTableView.m
//  iMovie
//
//  Created by qianfeng on 15/5/12.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "NewsTableView.h"
#import "UIView+Additions.h"


@implementation NewsTableView

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
        self.rowHeight = 60;
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsCell *cell = [self dequeueReusableCellWithIdentifier:Identifier];
    if(cell == nil){
        cell = [[NewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Identifier];
        
    }
    cell.newsmodel = self.dataArray[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if([self.didDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]){
        [self.didDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
