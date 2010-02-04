//
//  TeePee.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/3/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TeePee.h"
#import "NSObject+Missing.h"

#define TEE_PEE_KEYS [NSArray arrayWithObjects:@"delegate",@"onSuccess",@"onFailure",@"get",@"post",@"put",@"delete",nil]

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
	
  NSString *httpMethod = [[signature componentsSeparatedByString:@":"] objectAtIndex:0];
  
  [self requestForPath:[params objectForKey:httpMethod]];
  [self paramsForRequest:[params mutableCopy]];
  
  [self.request setRequestMethod:[httpMethod uppercaseString]];
  [[self requestQueue] addOperation:self.request];
}

- (void)addDictionaryParams:(NSDictionary*)dict 
                     forKey:(NSString*)key
{
  for (id paramKey in dict) {
    NSString *name  = [NSString stringWithFormat:@"%@[%@]",key,paramKey];
    NSString *value = [[dict objectForKey:paramKey] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self.request setPostValue:value forKey:name];
  }
}

- (void)addArrayParams:(NSArray *)array 
                forKey:(NSString *)key
{
  for (int c = 0; c<[array count]; c++) {
    NSString *name    = [NSString stringWithFormat:@"%@[%d]",key,c];
    NSString *value   = [[array objectAtIndex:c] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [self.request setPostValue:value forKey:name];
  }
}

- (void)stripParams:(NSMutableDictionary*)params
{
  [params removeObjectsForKeys:TEE_PEE_KEYS];
}

- (void)paramsForRequest:(NSMutableDictionary*)params
{
	[self stripParams:params];
	for (id key in params) {
    id param = [params valueForKey:key];
    if ([param respondsToSelector:@selector(objectForKey:)]) {
      [self addDictionaryParams:param forKey:key];
    }else if ([param respondsToSelector:@selector(objectAtIndex:)]){
      [self addArrayParams:param forKey:key];
    }else{
      [self.request setPostValue:[params valueForKey:key] forKey:key];
    }
	}
}

- (void)paramStringForRequest:(NSMutableDictionary*)params
{
  
}

- (void)requestForPath:(NSString*)path
{
	if (![self requestQueue]) {
  	[self setRequestQueue:[[[NSOperationQueue alloc] init] autorelease]];
  }
  
  NSURL *url 		= [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://localhost:9393",path]];
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
