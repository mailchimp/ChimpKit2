//
//  NSDictionary+Parameterize.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/4/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary(Parameterize)
- (NSDictionary*)parameterizeWithScope:(NSString*)scope;
- (NSString*)toQueryStringWithScope:(NSString*)scope;
@end
