//
//  ycp.m
//  yuchengpeng
//
//  Created by qianfeng on 15/6/5.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "ycp.h"

@implementation ycp

//1.
-(NSArray *)symmetryArray:(NSArray *)arr{
    
    NSMutableArray *marr = [NSMutableArray array];
    NSEnumerator *enumerater;
    
    
    //正转
    enumerater = [arr objectEnumerator];

    id thingie;
    while (thingie = [enumerater nextObject]) {
        [marr addObject:thingie];
    }
    
    //反转
    enumerater = [arr reverseObjectEnumerator];
    
    id object;
    while (object = [enumerater nextObject]) {
        [marr addObject:object];
    }
    
    return marr;
}

//2.
-(NSString *)longestStringInArray:(NSArray *)arr{
    
    //NSMutableArray *marr = [NSMutableArray array];
    int max = 0;
    for (NSString *str in arr) {
        NSRange range = NSMakeRange(0, str.length);
        int  maxl =(int)NSMaxRange(range);
        
        if (maxl>max) {
            max = maxl;
        }
    }
    return [NSString stringWithFormat:@"%d",max];
}

//3.
-(void)question3
{
//    printf("Input Ch:");
//    char *ch= getchar();
//    NSMutableString *string = [NSMutableString string];
//    for (int i=0; i<strlen(ch); i++) {
//        
//    }
    
    NSLog(@"input string");
    NSString *string = @"abcd";
    NSMutableString *nsstring = [NSMutableString string];
    //[nsstring appendString:string];
    for(int i=0;i<string.length;i++)
    {
        unichar c = [string characterAtIndex:string.length - i -1];
        [nsstring appendFormat:@"%c",c];
    }
    //return nsstring;
}


//4.
-(void)question4{
    NSString *str =@"Welcome to Beijing";
    
    NSMutableString *string = [NSMutableString string];
    NSMutableArray * arr = [NSMutableArray array];
    if ([str containsString:@" "]) {
        NSRange range = NSRangeFromString(@" ");
        [arr addObject:[str substringToIndex:range.location]];
    }
    NSEnumerator *enmer = [arr reverseObjectEnumerator];
    
    
    id  object;
    while (object == [enmer nextObject]) {
        [string appendFormat:@"%@ ",object];
    }
    
    
}

//5.
-(void)question5{
    NSString *str =@"AbCd";
    [str lowercaseString];
    [str uppercaseString];
}

//6

//7
-(void)question7{
    NSString *str =@"HelloMyWorld";
    //1 判断大小写
    char ch = str;
    if(ch >'A'&& ch<'Z')
    {
       
    }
    
}

+(void)test
{
    
}
@end
