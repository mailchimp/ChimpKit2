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
    self.baseUri  = "http://api.mailchimp.com/1.2";
		self.delegate = aDelegate;
	}
	return self;
}

@end
