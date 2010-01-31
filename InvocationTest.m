#import "GHUnit.h"
#import "GHAsyncTestCase.h"
#import "NSObject+Missing.h"

// Used for spoofing argument length of any dynamic method.
#define LOTS_OF_ARGS "@^v@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

@interface Mock : NSObject {}
+ (void)methodMissing:(NSString*)method withParams:(NSDictionary*)params;
@end

@implementation Mock

/*
+ (void)forwardInvocation:(NSInvocation *)invocation
{
  
	NSString				*selectorString = NSStringFromSelector([invocation selector]);
	NSArray					*keys						= [selectorString componentsSeparatedByString: @":"];
	NSString				*httpMethod			= [keys objectAtIndex:0];
	NSArray					*paramNames			= [keys objectsAtIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(1, [keys count]-2)]];
	NSMutableArray	*values					= [[NSMutableArray alloc] init];
	NSString				*method;
	
	[invocation getArgument:&method atIndex:2];
	
	for (int i=1; i<[paramNames count]+1; i++) {
		id arg;
		[invocation getArgument:&arg atIndex:i+2];
		[values addObject:arg];
	}
  
	NSDictionary *params = [NSMutableDictionary dictionaryWithObjects:values forKeys:paramNames];
	
	[self httpSend:httpMethod
			withMethod:method 
			 andParams:params];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
	return [NSMethodSignature signatureWithObjCTypes:LOTS_OF_ARGS];;
}


+ (void)httpSend:(NSString*)httpMethod withMethod:(NSString*)method andParams:(NSDictionary*)params
{
	NSLog(@"calling %@:%@ with %@",httpMethod,method,params);
}
*/

+ (void)methodMissing:(NSString*)method withParams:(NSDictionary*)params
{
  NSLog(@"%@",params);
}

@end


// GHUnit Test
@interface InvocationTest : GHAsyncTestCase { }
@end

@implementation InvocationTest

- (void)testClassMethodForwarding 
{
	[Mock get:@"doSomething" param1:@"foo" param2:@"bar"];
	[Mock post:@"doSomething" param1:@"hoge" param2:@"fuga" param3:@"piyo"];
}

- (void)testInstanceForwarding 
{
  Mock *m = [[Mock alloc] init];
	[m get:@"doSomething" param1:@"foo" param2:@"bar"];
	[m post:@"doSomething" param1:@"hoge" param2:@"fuga" param3:@"piyo"];
}

@end