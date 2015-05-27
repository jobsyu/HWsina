//
//  AppDelegate.h
//  iSocial
//
//  Created by Felipe on 9/3/12.
//  Copyright (c) 2012 Felipe Laso Marsetti. All rights reserved.
//

#import <UIKit/UIKit.h>

#define AccountFacebookAccountAccessGranted @"FacebookAccountAccessGranted"
#define AccountTwitterAccountAccessGranted @"TwitterAccountAccessGranted"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ACAccountStore *accountStore;
@property (strong, nonatomic) ACAccount  *facebookAccount;
@property (strong, nonatomic) ACAccount  *twitterAccount;
@property (strong, nonatomic) ACAccount  *sinaweiboAccount;

-(void)getFacebookAccount;
-(void)getTwitterAccount;
-(void)presentErrorWithMessage:(NSString *)errorMessage;

@end
