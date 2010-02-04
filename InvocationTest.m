#import "GHUnit.h"
#import "GHAsyncTestCase.h"
#import "NSObject+Missing.h"

@interface Mock : NSObject {}

@end

@implementation Mock
+ (void)methodMissing:(NSString*)method withParams:(NSDictionary*)params
{
  //NSLog(@"%@",params);
}
@end

@interface InvocationTest : GHAsyncTestCase { }
@end

@implementation InvocationTest

- (void)testClassMethodForwarding 
{
  //NSMutableArray *opts = [NSMutableArray arrayWithObjects:@"hoge","piyo",nil];
	[Mock get:@"doSomething" param1:@"foo" param2:@"bar"];
	//[Mock post:@"doSomething" param1:@"hoge" param2:@"fuga" delegate:self foo:opts onSuccess:@"loadedData"];
}

- (void)testInstanceForwarding 
{
  Mock *m = [[Mock alloc] init];
	[m get:@"doSomething" param1:@"foo" param2:@"bar"];
	[m post:@"doSomething" param1:@"hoge" param2:@"fuga" param3:@"piyo"];
}

@end