//
//  LaunchViewController.m
//  iMovie
//
//  Created by qianfeng on 15/5/11.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@end

@implementation LaunchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *view = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.view = view;
    [self _setViewBackGroundImage];
    [self _loadLogoImage];
    [self _showLogoImage];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)_setViewBackGroundImage{
    if(kSCREEN_HEIGHT == 568){
        UIImageView *view = (UIImageView *)self.view;
        view.image = [UIImage imageNamed:@"Default-568h.png"];
        _count = 18;
        _height = 81;
        _maxRow = 7;
    } else if(kSCREEN_HEIGHT == 480){
        UIImageView *view = (UIImageView *)self.view;
        view.image = [UIImage imageNamed:@"Default12.png"];
        _count = 16;
        _height = 80;
        _maxRow = 6;
    }
}


-(void) _loadLogoImage{
    
    float x =0,y = 0;
    for (int i =0; i<_count; i++) {
        
        
        UIImageView  *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, 80, _height)];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        //imageView.width = 80;
        imageView.tag = 100+i;
        imageView.alpha = 0;
        //imageView.height = _height;
        //imageView.left += x;
        //imageView.top += y;
        
        if (i<3) {
            x += 80;
        }else if (i>=3 && i<_maxRow+2){
            y += _height;
        }else if (i>=_maxRow+2 && i<_maxRow+5){
            x -= 80;
        }else{
            y -= _height;
        }
        
        [self.view addSubview:imageView];
    }       
    
}


static int i=0;
-(void)_showLogoImage{
    if(i > (_count -1)){
        if([self.delegate respondsToSelector:@selector(showLaunchViewDidEnd)]){
            [self.delegate showLaunchViewDidEnd];
        }
        return;
    }
    UIImageView *imageView =(UIImageView *)[self.view viewWithTag:100+i];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.alpha =1;
    }];
    i++;
    [self performSelector:@selector(_showLogoImage) withObject:nil afterDelay:0.2];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
