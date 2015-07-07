//
//  HWStatusDetailController.m
//  HWsina
//
//  Created by qianfeng on 15/6/18.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWStatusDetailController.h"
#import "HWStatusDetailCellFrame.h"
#import "HWStatusDetailCell.h"


@interface HWStatusDetailController ()
@property (nonatomic,strong) HWStatusDetailCellFrame *detailCellFrame;
@end

@implementation HWStatusDetailController
kHideScroll

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"微博正文";
    _detailCellFrame  = [[HWStatusDetailCellFrame alloc] init];
    _detailCellFrame.status = _status;
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    HWStatusDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HWStatusDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.statusCellFrame = _detailCellFrame;
    cell.status = _detailCellFrame.status;
    return cell;
}
@end
