//
//  webRequest.m
//  Al-Ebda'a Center
//
//  Created by user on 06/09/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import "WebRequest.h"
#import "Reachability.h"
@implementation WebRequest

+(void)AsyncRequestForArray:(NSString*)url onCompletion:(RequestCompletionHandlerForArray)complete
{
    NSOperationQueue *backgroudQueue = [[NSOperationQueue alloc]init];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:60];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroudQueue
                           completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
    {
        NSError *eror=nil;
        NSArray *jsonArray = nil;
        if(data!=nil)
        {
            jsonArray = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&eror ];
            if (complete) complete(jsonArray,error);
        }
        else
        {
            if (complete) complete(jsonArray,error);
        
        }
    }];
}

+(void)AsyncRequestForDic:(NSString*)url onCompletion:(RequestCompletionHandlerForDic)complete
{
    NSOperationQueue *backgroudQueue = [[NSOperationQueue alloc]init];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLCacheStorageAllowedInMemoryOnly timeoutInterval:60];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroudQueue
                           completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
     {
         NSError *eror=nil;
         NSDictionary *jsonDic = nil;
         if(data!=nil)
         {
             jsonDic = [ NSJSONSerialization JSONObjectWithData:data options:0 error:&eror ];
             if (complete) complete(jsonDic,error);
         }
         else
         {
             if (complete) complete(jsonDic,error);

         }
     }];
}

+(void)AsyncRequestForData:(NSString*)url onCompletion:(RequestCompletionHandlerForData)complete
{
    NSOperationQueue *backgroudQueue = [[NSOperationQueue alloc]init];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60];
     dispatch_semaphore_t holdOn = dispatch_semaphore_create(0);
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:backgroudQueue
                           completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
     {
         if(data!=nil)
         {
             if (complete) complete(data,error);
         }
         else
         {
             if (complete) complete(data,error);
         
         }
         dispatch_semaphore_signal(holdOn);
     }];
    
}

+(void)AsyncPostRequestForData:(NSString*)url :(NSString *)param onCompletion:(RequestCompletionHandlerForData)complete
{
    NSString *tempstr = [NSString stringWithString:param];
    NSData *tempdata = [tempstr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSString *datalength = [ NSString stringWithFormat:@"%lu",(unsigned long)tempdata.length ];
    NSURL *urll = [NSURL URLWithString:url];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:urll];
    [urlRequest setHTTPMethod: @"POST"];
    [urlRequest setValue:datalength forHTTPHeaderField:@"Content-Length"];
    [urlRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [urlRequest setTimeoutInterval:60.0];
    [urlRequest setHTTPBody:tempdata];
    
    NSOperationQueue *backgroudQueue = [[NSOperationQueue alloc]init];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:backgroudQueue
                           completionHandler:^(NSURLResponse *response,NSData *data,NSError *error)
     {
         if(data!=nil)
         {
             if (complete) complete(data,error);
         }
         else
         {
             if (complete) complete(data,error);
             
         }
     }];
}




#pragma Marks - Send Sync Request

+(NSData *)SyncRequestForDataWithParam:(NSString *)param Url:(NSString *)url AndMethod:(NSString *)Method
{
    NSData *respdata = nil;
    
    if([Method isEqualToString:@"POST"])
    {
        
        //POST Method
        NSString *tempstr = [NSString stringWithString:param];
        NSData *tempdata = [tempstr dataUsingEncoding:NSUTF8StringEncoding];
        
        
        NSString *datalength = [ NSString stringWithFormat:@"%lu",(unsigned long)tempdata.length ];
        NSURL *uri = [NSURL URLWithString:url];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:uri];
        [urlRequest setHTTPMethod: @"POST"];
        [urlRequest setValue:datalength forHTTPHeaderField:@"Content-Length"];
        [urlRequest setValue:@"application/x-www-form-urlencoded"
          forHTTPHeaderField:@"Content-Type"];
        [urlRequest setTimeoutInterval:60.0];
        [urlRequest setCachePolicy:NSURLCacheStorageAllowedInMemoryOnly];
        [urlRequest setHTTPBody:tempdata];
        NSURLResponse *response = nil;
        NSError *error = nil;
        
        respdata =[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        
        if (response) {
            NSHTTPURLResponse* newResp = (NSHTTPURLResponse*)response;
            NSLog(@"%d", newResp.statusCode);
            
            NSString *respstr =  [[NSString alloc]initWithData:respdata encoding:NSUTF8StringEncoding];
            NSLog(@"Response string: %@", respstr);
            
            return respdata;
            
        }
        else {
            NSLog(@"No response received");
            return respdata;
        }
    }
    else
    {
        //GET Method
        NSURL *uri = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",url,param]];
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:uri];
        [urlRequest setHTTPMethod: @"GET"];
        [urlRequest setTimeoutInterval:60.0];
        [urlRequest setCachePolicy:NSURLCacheStorageAllowedInMemoryOnly];
        NSURLResponse *response = nil;
        NSError *error = nil;
        
        respdata =[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
        
        if (response) {
            NSHTTPURLResponse* newResp = (NSHTTPURLResponse*)response;
            NSLog(@"%d", newResp.statusCode);
            
            NSString *respstr =  [[NSString alloc]initWithData:respdata encoding:NSUTF8StringEncoding];
            NSLog(@"Response string: %@", respstr);
            
            return respdata;
            
        }
        else {
            NSLog(@"No response received");
            return respdata;
        }
        
        
    }

}


#pragma Mark - Check internet Connection

+(BOOL) CheckNetowrkConnection{
    
    BOOL isInternet = NO;
    
    Reachability* reachability = [Reachability reachabilityWithHostName:@"www.google.com"];
    NetworkStatus remoteHostStatus = [reachability currentReachabilityStatus];
    
    if(remoteHostStatus == NotReachable)
    {
        isInternet =NO;
    }
    else if (remoteHostStatus == ReachableViaWWAN)
    {
        isInternet = YES;
    }
    else if (remoteHostStatus == ReachableViaWiFi)
    {
        isInternet = YES;
        
    }
    return isInternet;
}

@end
