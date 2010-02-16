#import "GHUnit.h"
#import "GHAsyncTestCase.h"
#import "NSObject+Missing.h"
#import "ChimpKit.h"

@interface ChimpKitTest : GHAsyncTestCase { 
  ChimpKit *ck;
}
@property(nonatomic,retain) ChimpKit *ck;
@end

@implementation ChimpKitTest

@synthesize ck;

- (void)setUp
{
  ck            = [[ChimpKit alloc] initWithDelegate:self];
  ck.onFailure  = @selector(didFail:);
  ck.onSuccess  = @selector(didLoad:);
}

- (void)testLists
{
  [self prepare];
  [ck get:@"/" method:@"lists" onSuccess:@"didLoadLists:"];
  [self waitForStatus:kGHUnitWaitStatusSuccess timeout:2.0];
}

- (void)didLoadLists:(NSDictionary*)data
{
  [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testLists)];
  GHAssertTrue([data respondsToSelector:@selector(objectAtIndex:)],nil);
}

- (void)didFail:(ASIHTTPRequest *)request
{
  NSLog(@"failed with %@",[request error]);
}

@end