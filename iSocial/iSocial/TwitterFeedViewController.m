//
//  TwitterFeedViewController.m
//  iSocial
//
//  Created by Felipe on 9/3/12.
//  Copyright (c) 2012 Felipe Laso Marsetti. All rights reserved.
//

#import "TwitterFeedViewController.h"
#import "AppDelegate.h"
#import "TwitterCell.h"

@interface TwitterFeedViewController()
@property (strong,atomic) NSArray *tweetsArray ;
@property (strong,atomic) NSMutableDictionary *imagesDictionary;

@end

@implementation TwitterFeedViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refreshTwitterFeed) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTwitterFeed) name:AccountTwitterAccountAccessGranted object:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if(appDelegate.twitterAccount)
    {
        [self refreshTwitterFeed];
    }
    else
    {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate getTwitterAccount];
    }
}

-(void)refreshTwitterFeed
{
    //1
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"] parameters:@{@"count": @"50"}];
    
    //2
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    request.account = appDelegate.twitterAccount;
    
    //3
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        [self.refreshControl endRefreshing];
        
        //4
        if(error)
        {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            //[appDelegate p]
            [appDelegate presentErrorWithMessage:[NSString stringWithFormat:@"These was an error reading your Twitter feed.%@",[error localizedDescription]]];
        }
        else
        {
            NSError *jsonError;
            NSArray *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
            
            if (jsonError) {
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
               // [appDelegate ]
                [appDelegate presentErrorWithMessage:[NSString stringWithFormat:@"These was an error reading your Twitter feed.%@",[error localizedDescription]]];
            }
            else
            {
                self.tweetsArray = responseJSON;
                
                self.imagesDictionary = [NSMutableDictionary dictionary];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self.tableView reloadData];
                });
            }
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return [self ]
    return [self heightForCellAtIndex:indexPath.row];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tweetsArray.count;
}

-(CGFloat)heightForCellAtIndex:(NSUInteger)index
{
    NSDictionary *tweet = self.tweetsArray[index];
    
    CGFloat cellHeight = 50;
    
    NSString *tweetText =tweet[@"text"];
    
    CGSize labelHeight = [tweetText sizeWithFont:[UIFont systemFontOfSize:15.0f] constrainedToSize:CGSizeMake(700,250)];
    
    cellHeight += labelHeight.height;
    
    return cellHeight;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    //1
    TwitterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];
    
    //2
    NSDictionary *currentTweet = [self.tweetsArray objectAtIndex:indexPath.row];
    NSDictionary *currentUser = currentTweet[@"user"];
    
    //3
    cell.usernameLabel.text = currentUser[@"name"];
    cell.tweetLabel.text = currentTweet[@"text"];
    cell.tweetLabel.frame = CGRectMake(cell.tweetLabel.frame.origin.x, cell.tweetLabel.frame.origin.y, 700, ([self heightForCellAtIndex:indexPath.row]-50));
    
    //4
    NSString *userName = cell.usernameLabel.text;
    if (self.imagesDictionary[userName]) {
        //5
        cell.userImageView.image = self.imagesDictionary[userName];
    }
    else
    {
       //6
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSURL *imageURL =[NSURL URLWithString:[currentUser objectForKey:@"profile_image_url"]];
            
            __block NSData *imageData;
            //7
            dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                imageData = [NSData dataWithContentsOfURL:imageURL];
                
                [self.imagesDictionary setObject:[UIImage imageWithData:imageData] forKey:userName];
                
                dispatch_sync(dispatch_get_main_queue(), ^{
                
                    cell.userImageView.image = self.imagesDictionary[cell.usernameLabel.text];
                });
            });
        });
    }
    return cell;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self.view window] == nil) {
        self.view = nil;
        
        _imagesDictionary = nil;
        _tweetsArray = nil;
    }
}


-(void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
    
}
@end
