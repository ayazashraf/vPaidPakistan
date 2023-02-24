//
//  WebRequest.h
//  Web Request to url sync and Async request 
//
//  Created by user on 06/09/2013.
//  Copyright (c) 2013 ForeignTreeSystems. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestCompletionHandlerForArray)(NSArray*,NSError*);
typedef void (^RequestCompletionHandlerForDic)(NSDictionary*,NSError*);
typedef void (^RequestCompletionHandlerForData)(NSData*,NSError*);

@interface WebRequest : NSObject

+(void)AsyncRequestForArray:(NSString*)url onCompletion:(RequestCompletionHandlerForArray)complete;
+(void)AsyncRequestForDic:(NSString*)url onCompletion:(RequestCompletionHandlerForDic)complete;
+(void)AsyncRequestForData:(NSString*)url onCompletion:(RequestCompletionHandlerForData)complete;
+(void)AsyncPostRequestForData:(NSString*)url :(NSString *)param onCompletion:(RequestCompletionHandlerForData)complete;

+(NSData *)SyncRequestForDataWithParam:(NSString *)param Url:(NSString *)url AndMethod:(NSString *)Method;

+(BOOL) CheckNetowrkConnection;

@end