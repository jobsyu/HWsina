//
//  HWProfileViewController.m
//  HWsinaweibo
//
//  Created by qianfeng on 15/6/1.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "HWProfileViewController.h"

@interface HWProfileViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation HWProfileViewController

static NSString *cellIdentifier = @"ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"添加好友" style:0 target:self action:@selector(addFriend)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self action:@selector(setting)];
    // Do any additional setup after loading the view.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 2;
    } else if (section== 1 || section == 2){
        return 3;
    } else {
        return 1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row =  indexPath.row;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        switch (section) {
            case 0:
                if (row == 0) {
                    cell.textLabel.text = @"新的好友";
                }else {
                    cell.textLabel.text = @"微博等级";
                }
                cell.imageView.image =[UIImage imageNamed:@"new_friend"];
                break;
            case 1:
                if (row == 0) {
                    cell.textLabel.text =@"我的相册";
                    cell.imageView.image = [UIImage imageNamed:@"album"];
                } else if (row == 1){
                    cell.textLabel.text =@"我的点评";
                    cell.imageView.image = [UIImage imageNamed:@"pay"];
                }else{
                    cell.textLabel.text =@"我的赞";
                    cell.imageView.image = [UIImage imageNamed:@"like"];
                }
                break;
            case 2:
                if (row == 0) {
                    cell.textLabel.text =@"微博支付";
                    cell.imageView.image = [UIImage imageNamed:@"pay"];
                } else if (row == 1){
                    cell.textLabel.text =@"微博运动";
                }else{
                    cell.textLabel.text =@"个性化";
                    cell.imageView.image = [UIImage imageNamed:@"vip"];
                }
                break;
            case 3:
                if (row == 0) {
                    cell.textLabel.text =@"草稿箱";
                    cell.imageView.image = [UIImage imageNamed:@"draft"];
                }
                break;
            case 4:
                if (row == 0) {
                    cell.textLabel.text =@"更多";
                    cell.imageView.image = [UIImage imageNamed:@"collect"];
                }
                break;
        }
    }
    return cell;
}

@end
