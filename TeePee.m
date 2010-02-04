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

@synthesize delegate, requestQueue, onSuccess, onFailure, request, baseUri;

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
	
  NSString *httpMethod  = [[signature componentsSeparatedByString:@":"] objectAtIndex:0];
  NSString *path        = [params objectForKey:httpMethod];
  
  [self requestForPath:path withParams:params];
  if (![httpMethod isEqualToString:@"get"]) {
    [self paramsForRequest:[params mutableCopy]];
  }

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

- (NSString*)concatDictionaryParams:(NSDictionary*)dict 
                        forKey:(NSString*)key
{
  NSString *queryString = @"";
  for (id paramKey in dict) {
    NSString *name  = [NSString stringWithFormat:@"%@[%@]",key,paramKey];
    NSString *value = [[dict objectForKey:paramKey] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",name,value]];
  }
  return queryString;
}
- (NSString*)concatArrayParams:(NSArray*)array 
                   forKey:(NSString*)key
{
  NSString *queryString = @"";
  for (int c = 0; c<[array count]; c++) {
    NSString *name    = [NSString stringWithFormat:@"%@[%d]",key,c];
    NSString *value   = [[array objectAtIndex:c] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",name,value]];
  }
  return queryString;
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
      // handle dictionary
      [self addDictionaryParams:param forKey:key];
    }else if ([param respondsToSelector:@selector(objectAtIndex:)]){
      // handle array
      [self addArrayParams:param forKey:key];
    }else{
      // handle string
      [self.request setPostValue:[params valueForKey:key] forKey:key];
    }
	}
}

- (NSString*)paramStringForRequest:(NSMutableDictionary*)params
{
  NSString *queryString = @"";
  [self stripParams:params];
  for (id key in params) {
    id param = [params valueForKey:key];
    if ([param respondsToSelector:@selector(objectForKey:)]) {
      // handle dictionary
      queryString = [queryString stringByAppendingString:[self concatDictionaryParams:param forKey:key]];
    }else if ([param respondsToSelector:@selector(objectAtIndex:)]){
      // handle array
      queryString = [queryString stringByAppendingString:[self concatArrayParams:param forKey:key]];
    }else{
      // handle string
      NSString *value = [[params objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
      queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",key,value]];
    }
	}
  return queryString;
}

- (void)requestForPath:(NSString*)path withParams:(NSDictionary*)params
{
	
  if (![self requestQueue]) {
  	[self setRequestQueue:[[[NSOperationQueue alloc] init] autorelease]];
  }
  
  NSString  *urlString  = [NSString stringWithFormat:@"%@%@?%@",self.baseUri,path,[self paramStringForRequest:[params mutableCopy]]];
  NSURL     *url        = [NSURL URLWithString:urlString];
  self.request          = [ASIFormDataRequest requestWithURL:url];
  
  [self.request setDelegate:self];
  [self.request setDidFinishSelector:@selector(tp_requestDidLoad:)];
  [self.request setDidFailSelector:@selector(tp_requestDidFail:)];
  
}

- (void)tp_requestDidLoad:(ASIFormDataRequest*)aRequest
{
  [self.delegate performSelector:self.onSuccess withObject:[[aRequest responseString] JSONValue]];
}
- (void)tp_requestDidFail:(ASIFormDataRequest*)aRequest
{
  [self.delegate performSelector:self.onFailure withObject:aRequest];
}

- (void)methodMissing:(NSString*)method withParams:(NSDictionary*)params
{
	[self parseParamDefaults:params];
	[self dispatchRequest:method withParams:params];
}


@end
