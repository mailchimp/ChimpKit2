//
//  TeePee.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/3/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import "TeePee.h"
#import "NSObject+Missing.h"
#import "NSDictionary+Parameterize.h"

#define TEE_PEE_KEYS [NSArray arrayWithObjects:@"delegate",@"onSuccess",@"onFailure",@"get",@"post",@"put",@"delete",nil]

@implementation TeePee

@synthesize delegate, requestQueue, onSuccess, onFailure, request, baseUri, requestParams;

- (id)initWithDelegate:(id)aDelegate
{
  self = [super init];
  if (self != nil) {
    self.requestParams = [[NSMutableDictionary alloc] init];
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

- (void)addParamsToRequest
{
  for (id key in self.requestParams) {
    [self.request setPostValue:[self.requestParams objectForKey:key] forKey:key];
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
    if ([param respondsToSelector:@selector(objectForKey:)] || [param respondsToSelector:@selector(objectAtIndex:)]) {
      [self.requestParams addEntriesFromDictionary:[param parameterizeWithScope:key]];
    }else{
      [self.requestParams setObject:[params valueForKey:key] forKey:key];
    }
  }
  [self addParamsToRequest];
}

- (NSString*)paramStringForRequest:(NSMutableDictionary*)params
{
  NSString *queryString = @"";
  [self stripParams:params];
  for (id key in params) {
    id param = [params valueForKey:key];
    if ([param respondsToSelector:@selector(objectForKey:)] || [param respondsToSelector:@selector(objectAtIndex:)]) {
      queryString = [queryString stringByAppendingString:[param toQueryStringWithScope:key]];
    }else{
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
  
  [self paramsForRequest:[params mutableCopy]];
  
  NSString  *urlString  = [NSString stringWithFormat:@"%@%@?%@",self.baseUri,path,[self paramStringForRequest:self.requestParams]];
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
