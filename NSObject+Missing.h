//
//  NSObject+Missing.h
//  ChimpKit
//
//  Created by Christopher Burnett on 1/30/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSObject(MethodMissing)

+ (void)methodMissing:(NSString*)method withParams:(NSDictionary*)params;

@end
