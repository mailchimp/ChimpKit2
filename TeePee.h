//
//  TeePee.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "NSObject+Missing.h"

@interface TeePee : NSObject 
{
	id  delegate;
	SEL onSuccess;
	SEL onFailure;
	NSOperationQueue 	*requestQueue;
	ASIFormDataRequest 		*request;
}

@property (assign,readwrite) id delegate;
@property (nonatomic,readwrite) SEL onSuccess;
@property (nonatomic,readwrite) SEL onFailure;
@property (nonatomic,retain) 		NSOperationQueue 	*requestQueue;
@property (nonatomic,retain) 		ASIFormDataRequest 		*request;

- (id)initWithDelegate:(id)aDelegate;
- (void)parseParamDefaults:(NSDictionary*)params;
- (void)paramsForRequest:(NSMutableDictionary*)params;
- (void)paramStringForRequest:(NSMutableDictionary*)params;
- (void)requestForPath:(NSString*)path;
- (void)dispatchRequest:(NSString*)signature 
             withParams:(NSDictionary*)params;
- (void)addDictionaryParams:(NSDictionary*)dict 
                     forKey:(NSString*)key;
- (void)stripParams:(NSMutableDictionary*)params;
@end
