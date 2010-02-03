//
//  NSObject+Missing.m
//  ChimpKit
//
//  Created by Christopher Burnett on 1/30/10.
//  Copyright 2010 twoism. All rights reserved.
//
//  Makes handling missing methods more ruby like.

#import "NSObject+Missing.h"

// Used for spoofing argument length of any dynamic method.
#define LOTS_OF_ARGS "@^v@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

@implementation NSObject(MethodMissing)

+ (void)forwardInvocation:(NSInvocation *)invocation
{
  [self handleInvocation:invocation];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
  [[self class] handleInvocation:invocation];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
  return [self formatDynamicSignature];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
  return [[self class] formatDynamicSignature];
}

+ (NSMethodSignature*)formatDynamicSignature
{
  return [NSMethodSignature signatureWithObjCTypes:LOTS_OF_ARGS];
}

+ (void)handleInvocation:(NSInvocation*)invocation
{
  NSString        *selectorString = NSStringFromSelector([invocation selector]);
  NSArray         *parts          = [selectorString componentsSeparatedByString: @":"];
  NSArray         *keys           = [parts objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [parts count]-1)]];
  NSMutableArray  *values         = [[NSMutableArray alloc] init];
  
  for (int i=0; i<[keys count]; i++) {
    id arg;
    [invocation getArgument:&arg atIndex:i+2];
    [values addObject:arg];
  }
  
  NSDictionary *params = [NSMutableDictionary dictionaryWithObjects:values 
                                                             forKeys:keys];
  
  if ([self respondsToSelector:@selector(methodMissing:withParams:)]) {
    
    [self performSelector:@selector(methodMissing:withParams:) 
               withObject:selectorString 
               withObject:params];
    
  }
}

@end
