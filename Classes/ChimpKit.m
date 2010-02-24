//
//  ChimpKit.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import "ChimpKit.h"

static NSString* ckAPIKey;

@implementation ChimpKit

+(void)setAPIKey:(NSString*)key
{
  ckAPIKey = key;
}

- (id)initWithDelegate:(id)aDelegate
{
	self = [super init];
	if (self != nil) {
    self.baseUri  = @"https://api.mailchimp.com/1.2";
		self.delegate = aDelegate;
    self.requestParams = [[NSMutableDictionary alloc] init];
    [self.requestParams setObject:ckAPIKey forKey:@"apikey"];
    [self.requestParams setObject:@"json" forKey:@"output"];
	}
	return self;
}

@end
