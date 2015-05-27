//
//  API.h
//  iReporter
//
//  Created by qianfeng on 15/5/4.
//  Copyright (c) 2015年 Marin Todorov. All rights reserved.
//

#import "AFHTTPClient.h"
#import "AFNetworking.h"

//API call completion block with result as json
typedef void (^JSONResponseBlock)(NSDictionary* json);

@interface API : AFHTTPClient
//the authorized user
@property (strong,nonatomic) NSDictionary *user;

//check whether there's an authorized user
-(BOOL)isAuthorized;
//definition a method to access the instance of the class
+(API*)shareInstance;

//send an API command to the server
-(void)commandWithParams:(NSMutableDictionary*)params
            onCompletion:(JSONResponseBlock)completionBlock;


-(NSURL*)urlForImageWithId:(NSNumber *)IdPhoto isThumb:(BOOL)isThumb;



@end
