//
//  NSArray+Parametrize.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/4/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Parametrize.h"


@implementation NSArray(Parametrize)
- (NSMutableDictionary*)parameterizeWithScope:(NSString*)scope
{
  NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
  for (int c = 0; c<[self count]; c++) {
    NSString *name    = [NSString stringWithFormat:@"%@[%d]",scope,c];
    NSString *value   = [[self objectAtIndex:c] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    [dict setObject:value
             forKey:name];
  }
  return dict;
}
- (NSString*)toQueryStringWithScope:(NSString*)scope
{
  NSString *queryString = @"";
  for (int c = 0; c<[self count]; c++) {
    NSString *name    = [NSString stringWithFormat:@"%@[%d]",scope,c];
    NSString *value   = [[self objectAtIndex:c] stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    queryString = [queryString stringByAppendingString:[NSString stringWithFormat:@"%@=%@&",name,value]];
  }
  return queryString;
}
@end
