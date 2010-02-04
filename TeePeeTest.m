#import "GHUnit.h"
#import "GHAsyncTestCase.h"
#import "NSObject+Missing.h"
#import "TeePee.h"

#define TEST_SERVER @"http://localhost:9393"

@interface TeePeeTest : GHAsyncTestCase { 
  
  TeePee *tp;

}
@property(nonatomic,retain) TeePee *tp;
@end

@implementation TeePeeTest

@synthesize tp;

- (void)setUp
{
  tp          = [[TeePee alloc] initWithDelegate:self];
  tp.baseUri  = TEST_SERVER;
}

- (void)testWithStrings
{
  [tp get:@"/" foo:@"bar" bar:@"hoge" onSuccess:@"didLoad:" onFailure:@"didFail:"];
}

- (void)testWithArray
{
  NSArray *opts = [NSArray arrayWithObjects:@"one",@"two",nil];
  [tp get:@"/" foo:@"bar" bar:opts onSuccess:@"didLoad:" onFailure:@"didFail:"];
}

- (void)testWithDictionary
{
  NSDictionary *opts  = [NSDictionary dictionaryWithObjectsAndKeys:@"one",@"foo",@"two",@"bar",nil];
  [tp put:@"/" bar:opts onSuccess:@"didLoad:" onFailure:@"didFail:"];
}

- (void)didLoad:(ASIHTTPRequest *)request
{
  NSLog(@"made it %@",[request responseString]);
}

- (void)didFail:(ASIHTTPRequest *)request
{
  NSLog(@"failed with %@",[request error]);
}

@end