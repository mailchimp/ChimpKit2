//
//  TeePee.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/3/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "NSObject+Missing.h"
#import "JSON.h"

@interface TeePee : NSObject 
{
	id  delegate;
	SEL onSuccess;
	SEL onFailure;
	NSOperationQueue    *requestQueue;
	ASIFormDataRequest 	*request;
  NSString            *baseUri;
  NSMutableDictionary *requestParams;
}

@property (assign,readwrite)    id delegate;
@property (nonatomic,readwrite) SEL onSuccess;
@property (nonatomic,readwrite) SEL onFailure;
@property (nonatomic,retain) 		NSOperationQueue    *requestQueue;
@property (nonatomic,retain) 		ASIFormDataRequest 	*request;
@property (nonatomic,retain) 		NSString            *baseUri;
@property (nonatomic,retain) 		NSMutableDictionary *requestParams;

- (id)initWithDelegate:(id)aDelegate;
- (void)parseParamDefaults:(NSDictionary*)params;
- (void)addParamsToRequest;
- (void)paramsForRequest:(NSMutableDictionary*)params;
- (NSString*)paramStringForRequest:(NSMutableDictionary*)params;
- (void)requestForPath:(NSString*)path withParams:(NSDictionary*)params;
- (void)dispatchRequest:(NSString*)signature 
             withParams:(NSDictionary*)params;
- (void)addDictionaryParams:(NSDictionary*)dict 
                     forKey:(NSString*)key;
- (void)addArrayParams:(NSArray*)array 
                forKey:(NSString*)key;
- (NSString*)concatDictionaryParams:(NSDictionary*)dict 
                             forKey:(NSString*)key;
- (NSString*)concatArrayParams:(NSArray*)array 
                        forKey:(NSString*)key;
- (void)stripParams:(NSMutableDictionary*)params;
- (void)tp_requestDidLoad:(ASIFormDataRequest*)request;
- (void)tp_requestDidFail:(ASIFormDataRequest*)request;
@end
