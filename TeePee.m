//
//  TeePee.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TeePee.h"
#import "NSObject+Missing.h"

@implementation TeePee

@synthesize delegate, requestQueue, onSuccess, onFailure, request;

- (id)initWithDelegate:(id)aDelegate
{
	self = [super init];
	if (self != nil) {
		self.delegate = aDelegate;
	}
	return self;
}

- (void)parseParamDefaults:(NSDictionary*)params
{
	if ([params objectForKey:@"delegate"]) {
		self.delegate = [params objectForKey:@"delegate"];
	}
	if ([params objectForKey:@"onSuccess"]) {
		self.onSuccess = NSSelectorFromString([params objectForKey:@"onSuccess"]);
	}
	if ([params objectForKey:@"onFailure"]) {
		self.onFailure = NSSelectorFromString([params objectForKey:@"onFailure"]);
	}
}

- (void)dispatchRequest:(NSString*)signature 
						 withParams:(NSDictionary*)params
{
	[self requestForPath:[params objectForKey:@"get"]];
  [self paramsForRequest:[params mutableCopy]];
  [self.request setRequestMethod:@"GET"];
  [[self requestQueue] addOperation:self.request];
}

- (NSDictionary*)parameterizeKey:(NSString*)key 
                      withObject:(id)obj
{
	NSDictionary *param;
	if ([obj respondsToSelector:@selector(objectForKey:)]) {
		// is dictionary
	}else if ([obj respondsToSelector:@selector(objectAtIndex:)]){
		// is array
	}else{
		// treat as string
	}
	return param;
}

- (void)paramsForRequest:(NSMutableDictionary*)params
{
	[params removeObjectsForKeys:[NSArray arrayWithObjects:@"delegate",@"onSuccess",@"onFailure",@"get",nil]];
	for (id key in params) {
    
    id param = [params valueForKey:key];
    
    if ([param respondsToSelector:@selector(objectForKey:)]) {
      for (id paramKey in param) {
        NSString *name  = [NSString stringWithFormat:@"%@[%@]",key,paramKey];
        NSString *value = [[param objectForKey:paramKey] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        [self.request setPostValue:value forKey:name];
      }
    }else if ([param respondsToSelector:@selector(objectAtIndex:)]){
      for (int c = 0; c<[param count]; c++) {
        NSString *name    = [NSString stringWithFormat:@"%@[%d]",key,c];
        NSString *value   = [[param objectAtIndex:c] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
        [self.request setPostValue:value forKey:name];
      }
    }else{
      [self.request setPostValue:[params valueForKey:key] forKey:key];
    }
	}
}

- (void)requestForPath:(NSString*)path
{
	if (![self requestQueue]) {
  	[self setRequestQueue:[[[NSOperationQueue alloc] init] autorelease]];
  }
  
  NSURL *url 		= [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://localhost:9393",@"/"]];
  self.request 	= [ASIFormDataRequest requestWithURL:url];
  
  [self.request setDelegate:self.delegate];
  [self.request setDidFinishSelector:self.onSuccess];
  [self.request setDidFailSelector:self.onFailure];
}

- (void)methodMissing:(NSString*)method withParams:(NSDictionary*)params
{
	[self parseParamDefaults:params];
	[self dispatchRequest:method withParams:params];
}

@end
