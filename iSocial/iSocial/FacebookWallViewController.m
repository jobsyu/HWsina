//
//  FacebookWallViewController.m
//  iSocial
//
//  Created by Felipe on 9/3/12.
//  Copyright (c) 2012 Felipe Laso Marsetti. All rights reserved.
//

#import "FacebookWallViewController.h"

@implementation FacebookWallViewController

-(NSString *)feedString
{
   return @"https://graph.facebook.com/me/feed";
}

-(NSString *)titleString
{
   return @"Wall";
}

@end
