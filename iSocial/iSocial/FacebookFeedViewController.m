//
//  FacebookFeedViewController.m
//  iSocial
//
//  Created by Felipe on 9/3/12.
//  Copyright (c) 2012 Felipe Laso Marsetti. All rights reserved.
//

#import "FacebookFeedViewController.h"
#import "AppDelegate.h"
#import "CommentViewController.h"
#import "FacebookCell.h"
#import "MessageCell.h"
#import "PhotoCell.h"
#import "WebViewController.h"

@interface FacebookFeedViewController()
@property (strong,atomic) NSArray *feedArray;
@property (strong,atomic) NSMutableDictionary *imagesDictionary;

@end


@implementation FacebookFeedViewController

-(NSString *)feedString
{
   return @"https://graph.facebook.com/me/home";
}

-(NSString *)titleString
{
   return @"Feed";
}

-(void)didReceiveMemoryWarning
{
    if ([self.view window] ==nil) {
        _feedArray = nil;
        _imagesDictionary = nil;
    }
    
    [super didReceiveMemoryWarning];
}


-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl =[[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshFacebookFeed) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    self.title = [self titleString];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshFacebookFeed) name:AccountFacebookAccountAccessGranted object:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (appDelegate.facebookAccount) {
        [self refreshFacebookFeed];
    }
    else
    {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate getFacebookAccount];
    }
}

-(void)refreshFacebookFeed
{
    // 1
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:[self feedString]] parameters:@{ @"limit" : @"30" }];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    request.account = appDelegate.facebookAccount;
    
    // 2
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        [self.refreshControl endRefreshing];
        
        if (error) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            [appDelegate presentErrorWithMessage:[NSString stringWithFormat:@"There was an error reading your Facebook feed. %@",[error.localizedDescription]]];
        }
        else
        {
            //4
            NSError *jsonError;
            NSDictionary *responseJSON =[NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError) {
                //5
                AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                [appDelegate presentErrorWithMessage: [NSString stringWithFormat:@"There was an error reading your Facebook feed. %@", [error localizedDescription]]];
            }
            else
            {
               //6
                NSMutableArray *cleanFeedArray = [NSMutableArray array];
                
                for (NSDictionary *item in responseJSON[@"data"]) {
                    if([item[@"type"] isEqualToString:@"status"] ||
                       [item[@"type"] isEqualToString:@"link"] ||
                       [item[@"type"] isEqualToString:@"photo"] ||
                       [item[@"type"] isEqualToString:@"video"])
                    {
                        if ([item[@"item"] isEqualToString:@"status"]) {
                            if (!item[@"message"]) {
                                continue;
                            }
                        }
                        
                        [cleanFeedArray addObject:item];
                    }
                }
                
                //7
                self.feedArray = [NSArray arrayWithArray:cleanFeedArray];
                self.imagesDictionary = [NSMutableDictionary dictionary];
                
                //8
                dispatch_async(dispatch_get_main_queue(), ^{
                   
                    [self.tableView reloadData];
                });
                
            }
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return [self heightForCellAtIndex:indexPath.row];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.feedArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   //1
    FacebookCell *cell;
    cell.userImageView.image = nil;
    
    //2
    NSDictionary *currentItem =[self.feedArray objectAtIndex:indexPath.row];
    NSDictionary *currentUser = currentItem[@"from"];
    NSString *currentUserID = currentUser[@"id"];
    
    //3
    if ([currentItem[@"type"] isEqualToString:@"status"]) {
        //Code to format status cell
        
        
        
    }
    //4
    else if ([currentItem[@"type"] isEqualToString:@"link"])
    {
        //Code to format link cell
    }
    //5
    else if ([currentItem[@"type"] isEqualToString:@"photo"] ||
             [currentItem[@"type"] isEqualToString:@"video"])
    {
       //Code to format photo or video cell
    }
    //6
    if(self.imagesDictionary[currentUserID])
    {
        cell.userImageView.image = self.imagesDictionary[currentUserID];
    }
    else
    {
        //7
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *pictureURL =[NSString stringWithFormat:@"%@/%@/picture?type=small", @"https://graph.facebook.com", currentUser[@"id"]];
            
            NSURL *imageURL = [NSURL URLWithString:pictureURL];
            
            __block NSData *imageData;
            
            //8
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                imageData = [NSData dataWithContentsOfURL:imageURL];
                
                [self.imagesDictionary setObject:[UIImage imageWithData:imageData] forKey:currentUserID];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                    cell.userImageView.image = self.imagesDictionary[currentUserID];
                });
            });
        });
    }
    return cell;
}

@end
