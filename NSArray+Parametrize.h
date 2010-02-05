//
//  NSArray+Parametrize.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/4/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray(Parametrize)
- (NSMutableDictionary*)parameterizeWithScope:(NSString*)scope;
- (NSString*)toQueryStringWithScope:(NSString*)scope;
@end
