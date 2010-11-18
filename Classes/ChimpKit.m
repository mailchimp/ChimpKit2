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

+(NSString *)getAPIKey
{
    return ckAPIKey;
}

- (id)initWithDelegate:(id)aDelegate
{
	self = [super init];
	if (self != nil) {
        self.baseUri  = @"https://api.mailchimp.com/1.2";
        self.delegate = aDelegate;
        self.requestParams = [[NSMutableDictionary alloc] init];
        
        if (ckAPIKey) {
            [self.requestParams setObject:ckAPIKey forKey:@"apikey"];
            
            //Parse out the datacenter and template it into the URL.
            NSArray *apiKeyParts = [ckAPIKey componentsSeparatedByString:@"-"];
            if ([apiKeyParts count] > 1) {
                self.baseUri = [NSString stringWithFormat:@"https://%@.api.mailchimp.com/1.2", [apiKeyParts objectAtIndex:1]];
            }
        }
        
        [self.requestParams setObject:@"json" forKey:@"output"];
	}
	return self;
}

@end
