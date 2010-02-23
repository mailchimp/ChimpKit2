#import "GHUnit.h"
#import "GHAsyncTestCase.h"
#import "CKList.h"

@interface CKListTest : GHAsyncTestCase { 
  CKList *list;
}
@property(nonatomic,retain) CKList *list;
@end

@implementation CKListTest

@synthesize list;

- (void)setUp
{
  list            = [[CKList alloc] initWithDelegate:self];
  list.onFailure  = @selector(didFail:);
  list.onSuccess  = @selector(didLoadLists:);
}

- (void)testLists
{
  [self prepare];
    [list findAll];
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