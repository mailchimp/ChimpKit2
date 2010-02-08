//
//  ChimpKit.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import "ChimpKit.h"


@implementation ChimpKit

- (id)initWithDelegate:(id)aDelegate
{
	self = [super init];
	if (self != nil) {
    self.baseUri  = @"https://api.mailchimp.com/1.2";
		self.delegate = aDelegate;
    self.requestParams = [[NSMutableDictionary alloc] init];
    [self.requestParams setObject:@"64f5d08d441ecbf463b046631b087a58-us1" forKey:@"apikey"];
    [self.requestParams setObject:@"json" forKey:@"output"];
	}
	return self;
}

@end
