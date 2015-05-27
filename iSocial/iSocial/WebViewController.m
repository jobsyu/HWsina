//
//  WebViewController.m
//  iSocial
//
//  Created by Felipe on 9/3/12.
//  Copyright (c) 2012 Felipe Laso Marsetti. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)doneTapped;

@end

@implementation WebViewController

#pragma mark - IBActions

- (IBAction)doneTapped
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View Lifecycle

- (void)didReceiveMemoryWarning
{
    if ([self.view window] == nil)
    {
        _initialURLString = nil;
        _webView = nil;
    }
    
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:self.initialURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

@end
