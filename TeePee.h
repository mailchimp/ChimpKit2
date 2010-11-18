//
//  TeePee.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/3/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "JSON.h"

@interface TeePee : NSObject 
{
  id  delegate;
  SEL onSuccess;
  SEL onFailure;
  NSOperationQueue    *requestQueue;
  ASIFormDataRequest  *request;
  NSString            *baseUri;
  NSMutableDictionary *requestParams;
  NSDictionary *userInfo;
}

@property (assign,readwrite)    id  delegate;
@property (nonatomic,readwrite) SEL onSuccess;
@property (nonatomic,readwrite) SEL onFailure;
@property (nonatomic,retain)    NSOperationQueue    *requestQueue;
@property (nonatomic,retain)    ASIFormDataRequest  *request;
@property (nonatomic,retain)    NSString            *baseUri;
@property (nonatomic,retain)    NSMutableDictionary *requestParams;
@property (nonatomic,retain)    NSDictionary *userInfo;

- (id)initWithDelegate:(id)aDelegate;
/*
 Checks for on the fly setting of the default params,
 delegate, onSuccess and onFailure.
*/
- (void)parseParamDefaults:(NSDictionary*)params;
/*
 I'll just leave it to your imagination to figure out
 what this one does.
*/
- (void)addParamsToRequest;
/*
 Packs requestParams with the values from the incoming args
 for the POST, PUT and DELETE http methods. Array & dictionary 
 values use their Parameterize Category for formating name / value pairs.
*/
- (void)paramsForRequest:(NSMutableDictionary*)params;
/*
 Builds a query string for the request to be used with the GET
 http method. Array & dictionary values use their Parameterize 
 Category for formating.
*/
- (NSString*)paramStringForRequest:(NSMutableDictionary*)params;
/*
 Sets up the ASIHTTPRequest sets the current class as the delegate 
 and sets the success and fail callbacks.
*/
- (void)requestForPath:(NSString*)path 
            withParams:(NSDictionary*)params;
/*
 Everything starts here after a methodMissing call is found.
*/
- (void)dispatchRequest:(NSString*)signature 
             withParams:(NSDictionary*)params;
/*
 Pulls out the args used for internals. See TEE_PEE_KEYS.
*/
- (void)stripParams:(NSMutableDictionary*)params;
/*
  Default callbacks used for dispatch of success and fail selectors.
*/
- (void)tp_requestDidLoad:(ASIFormDataRequest*)request;
- (void)tp_requestDidFail:(ASIFormDataRequest*)request;

+ (NSMethodSignature*)formatDynamicSignature;
+ (void)handleInvocation:(NSInvocation*)invocation;
- (void)handleInvocation:(NSInvocation*)invocation;
@end
