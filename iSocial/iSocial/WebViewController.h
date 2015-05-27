//
//  WebViewController.h
//  iSocial
//
//  Created by Felipe on 9/3/12.
//  Copyright (c) 2012 Felipe Laso Marsetti. All rights reserved.
//

#import <UIKit/UIKit.h>

#define WebViewControllerIdentifier     @"WebViewController"

@interface WebViewController : UIViewController

@property (strong, nonatomic) NSString *initialURLString;

@end