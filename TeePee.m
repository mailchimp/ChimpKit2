#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "ASIHTTPRequest.h"

@interface TeePee : NSObject 
{
	id  delegate;
	SEL onSuccess;
	SEL onFailure;
	NSOperationQueue 	*requestQueue;
	ASIHTTPRequest 		*request;
}

@property (nonatomic,readwrite) id delegate;
@property (nonatomic,readwrite) SEL onSuccess;
@property (nonatomic,readwrite) SEL onFailure;
@property (nonatomic,retain) 		NSOperationQueue 	*requestQueue;
@property (nonatomic,retain) 		ASIHTTPRequest 		*request;

- (id)initWithDelegate:(id)aDelegate;
- (void)parseParamDefaults:(NSDictionary*)params;
- (void)requestForPath:(NSString*)path;
- (void)dispatchRequest:(NSString*)signature 
             withParams:(NSDictionary*)params;
- (NSDictionary*)parameterizeKey:(NSString*)key 
						          withObject:(id)obj;

@end

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
	if ([params containsObject:@"delegate"]) {
		self.delegate = [params objectForKey:@"delegate"];
	}
	if ([params containsObject:@"onSuccess"]) {
		self.onSuccess = [params objectForKey:@"onSuccess"];
	}
	if ([params containsObject:@"onFailure"]) {
		self.onFailure = [params objectForKey:@"onFailure"];
	}
}

- (void)dispatchRequest:(NSString*)signature 
						 withParams:(NSDictionary*)params
{
	[self requestForPath:[params objectForKey:@"path"]];
	[self paramsForRequest:[params mutableCopy]];
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
	[params removeObjectsForKeys:[NSArray arrayWithObjects:@"delegate",@"onSuccess",@"onFailure"]];
	for (id key in params) {
		[self.request setPostValue:[params valueForKey:key] forKey:key];
	}
}

- (void)requestForPath:(NSString*)path
{
	if (![self requestQueue]) {
  	[self setRequestQueue:[[[NSOperationQueue alloc] init] autorelease]];
  }

  NSURL *url 		= [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://localhost:3000",path]];
  self.request 	= [ASIHTTPRequest requestWithURL:url];

  [self.request setDelegate:self.delegate];
  [self.request setDidFinishSelector:self.onSuccess];
  [self.request setDidFailSelector:self.onFailure];

  [[self requestQueue] addOperation:self.request];
}

- (void)methodMissing:(NSString*)methodSignature 
           withParams:(NSDictionary*)params
{
	[self parseParamDefaults:params];
	[self dispatchRequest:methodSignature withParams:params];
}

@end