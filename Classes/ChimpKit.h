//
//  ChimpKit.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TeePee.h"

@interface ChimpKit : TeePee { }

+(void)setAPIKey:(NSString*)key;
+(NSString *)getAPIKey;

@end
