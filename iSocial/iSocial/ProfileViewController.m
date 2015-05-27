//
//  ProfileViewController.m
//  iSocial
//
//  Created by Felipe on 9/3/12.
//  Copyright (c) 2012 Felipe Laso Marsetti. All rights reserved.
//

#import "ProfileViewController.h"
#import "AppDelegate.h"
#import "WebViewController.h"


@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UITextView *bioTextView;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIButton *facebookButton;
@property (weak, nonatomic) IBOutlet UILabel *genderLabel;
@property (weak, nonatomic) IBOutlet UILabel *hometownLabel;
@property (weak, nonatomic) IBOutlet UILabel *languagesLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *pictureImageView;
@property (weak, nonatomic) IBOutlet UILabel *relationshipStatusLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *websiteButton;
@property (strong) NSDictionary *profileDictionary;

- (IBAction)viewOnFacebookTapped;
- (IBAction)viewWebsiteTapped;

@end

@implementation ProfileViewController

#pragma mark - IBActions

- (IBAction)viewOnFacebookTapped
{
    NSString *urlString = self.profileDictionary[@"link"];
    
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:WebViewControllerIdentifier];
    webViewController.initialURLString = urlString;
    
    [self presentViewController:webViewController animated:YES completion:nil];
}

- (IBAction)viewWebsiteTapped
{
    NSString *urlString = self.profileDictionary[@"website"];
    
    WebViewController *webViewController = [self.storyboard instantiateViewControllerWithIdentifier:WebViewControllerIdentifier];
    webViewController.initialURLString = urlString;
    
    [self presentViewController:webViewController animated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadProfile) name:AccountFacebookAccountAccessGranted object:nil];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if (appDelegate.facebookAccount) {
        [self reloadProfile];
    }
    else
    {
        AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
        [appDelegate getFacebookAccount];
    }
}


-(void)reloadProfile
{
    //1
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeFacebook requestMethod:SLRequestMethodGET URL: [NSURL URLWithString:@"https://graph.facebook.com/me"] parameters:@{ @"fields" :@"bio,birthday,cover,email,first_name,gender,hometown,languages,la st_name,link,location,picture,relationship_status,security_setting s,username,website" }];
    
    // 2
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    request.account = appDelegate.facebookAccount;
    
    //3
    [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        if(error)
        {
           //4
            AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            [appDelegate presentErrorWithMessage:[NSString stringWithFormat:@"These was an error reading your Facebook Feed. %@",[error localizedDescription]]];
             
             
        }
        else
        {
            //5
            NSError *jsonError;
            NSDictionary *responseJSON = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
            
            if(jsonError)
            {
                //6
                AppDelegate *appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                [appDelegate presentErrorWithMessage:[NSString stringWithFormat:@"These was an error reading your Facebook Feed. %@",[error localizedDescription]]];
            }
            else
            {
               //7
                self.profileDictionary = responseJSON;
                [self getPictures];
                
                //8
                dispatch_async(dispatch_get_main_queue(),^{
                    self.bioTextView.text = self.profileDictionary[@"bio"];
                    self.birthdayLabel.text = self.profileDictionary[@"birthday"];
                    self.emailLabel.text = self.profileDictionary[@"email"];
                    self.genderLabel.text = self.profileDictionary[@"gender"];
                    self.hometownLabel.text = self.profileDictionary[@"hometown"][@"name"];
                    
                    NSArray *languages = self.profileDictionary[@"languages"];
                    NSMutableString *languagesString = [NSMutableString stringWithString:@""];
                    
                    for(int i=0; i<languages.count;i++)
                    {
                        NSDictionary *language = languages[i];
                        
                        [languagesString appendString:language[@"name"]];
                         
                         if(i  < (language.count -1))
                         {
                             [languagesString appendString:@", "];
                         }
                    }
                         
                     self.languagesLabel.text = [NSString stringWithString:languagesString];
                     
                     //10
                     
                     self.locationLabel.text = self.profileDictionary[@"location"][@"name"];
                     self.nameLabel.text = [NSString stringWithFormat:@"%@ %@",self.profileDictionary[@"first_name"],self.profileDictionary[@"last_name"]];
                     self.usernameLabel.text = self.profileDictionary[@"username"];
                     self.relationshipStatusLabel.text = self.profileDictionary[@"relationship_status"];
                    
                    //11
                     if(!self.profileDictionary[@"website"])
                     {
                         self.websiteButton.hidden = YES;
                     }
                     else
                     {
                         self.websiteButton.hidden = NO;
                     }
                     
                     self.facebookButton.hidden = NO;
                });
            }
        }
    }];
}

-(void)getPictures
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *pictureURLString = self.profileDictionary[@"picture"][@"data"][@"url"];
        
        NSURL *pictureURL = [NSURL URLWithString:pictureURLString];
        
        __block NSData *pictureData;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            pictureData =[NSData dataWithContentsOfURL:pictureURL];
            
            UIImage *pictureImage = [UIImage imageWithData:pictureData];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.pictureImageView.image = pictureImage;
            });
        });
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *coverURLString = self.profileDictionary[@"cover"][@"source"];
        
        NSURL *coverURL = [NSURL URLWithString:coverURLString];
        
        __block NSData *coverData;
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            coverData = [NSData dataWithContentsOfURL:coverURL];
            UIImage *coverImage = [UIImage imageWithData:coverData];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.coverImageView.image = coverImage;
            });
        });
        //UIImage *coverImage = [UIImage imageWithData:coverURLString];
    });
}



-(void)didReceiveMemoryWarning
{
    if([self.view window] == nil)
    {
        _bioTextView = nil;
        _birthdayLabel = nil;
        _coverImageView = nil;
        _emailLabel = nil;
        _genderLabel = nil;
        _hometownLabel = nil;
        _languagesLabel = nil;
        _locationLabel = nil;
        _nameLabel = nil;
        _pictureImageView =nil;
        _relationshipStatusLabel = nil;
        _usernameLabel =nil;
        _websiteButton = nil;
    }
    [super didReceiveMemoryWarning];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewWillDisappear:animated];
}

@end
