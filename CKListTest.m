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
  [ChimpKit setAPIKey:@"1df3dda132dc2338706decdd08198719-us1"];
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
  NSLog(@"%@",data);
  [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testLists)];
  GHAssertTrue([data respondsToSelector:@selector(objectAtIndex:)],nil);
}

- (void)didFail:(ASIHTTPRequest *)request
{
  NSLog(@"failed with %@",[request error]);
}


- (void)testSignup
{
  list.onFailure  = @selector(didFail:);
  list.onSuccess  = @selector(didSignup:);
  [self prepare];
  [list subscribe:@"e892b61220" withEmail:@"signalstatic@gmail.com" sendWelcome:NO];
  [self waitForStatus:kGHUnitWaitStatusSuccess timeout:2.0];
}

- (void)didSignup:(NSDictionary*)data
{
  [self notify:kGHUnitWaitStatusSuccess forSelector:@selector(testSignup)];
  NSLog(@"%@",data);
  //GHAssertTrue([data respondsToSelector:@selector(objectAtIndex:)],nil);
}

@end