//
//  NSDictionary+Parameterize.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Parameterize.h"


@implementation NSMutableDictionary(Parameterize)

- (NSMutableDictionary*)parameterizeWithScope:(NSString*)scope
{
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  for (id paramKey in self) {
    NSString *name  = [NSString stringWithFormat:@"%@[%@]",scope,paramKey];
    NSString *value = [[self objectForKey:paramKey] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [dict setObject:value forKey:name];
  }
  return dict;
}

- (NSString*)toQueryStringWithScope:(NSString*)scope
{
  NSString *queryString = @"";
  for (id paramKey in self) {
    NSString *name  = [NSString stringWithFormat:@"%@[%@]",scope,paramKey];
    NSString *value = [[self objectForKey:paramKey] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",name,value]];
  }
  return queryString;
}
@end
