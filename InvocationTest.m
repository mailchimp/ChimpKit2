#import "GHUnit.h"
#import "GHAsyncTestCase.h"


// Used for spoofing argument length of any dynamic method.
#define LOTS_OF_ARGS "@^v@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"

@interface Mock : NSObject {}

@end

@implementation Mock

+ (void)forwardInvocation:(NSInvocation *)invocation
{

	NSString				*selectorString = NSStringFromSelector([invocation selector]);
	NSMutableArray	*keys						= [selectorString componentsSeparatedByString: @":"];
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
		
	NSDictionary *dict = [NSMutableDictionary dictionaryWithObjects:values forKeys:paramNames];
	
	NSLog(@"%@:%@ with %@",httpMethod,method,dict);
}

/* Formats a generic siganture for missing methods */
+ (NSMethodSignature *)methodSignatureForSelector:(SEL)selector
{
	return [NSMethodSignature signatureWithObjCTypes:LOTS_OF_ARGS];;
}

@end


// GHUnit Test
@interface InvocationTest : GHAsyncTestCase { }
@end

@implementation InvocationTest

- (void)testMethodForwarding 
{
	//Mock *m = [[Mock alloc] init];
	[Mock get:@"doSomething" param1:@"foo" param2:@"bar"];
	[Mock post:@"doSomething" param1:@"hoge" param2:@"fuga" param3:@"piyo"];
}

@end