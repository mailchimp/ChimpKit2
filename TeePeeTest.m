#import "GHUnit.h"
#import "GHAsyncTestCase.h"
#import "NSObject+Missing.h"
#import "TeePee.h"


@interface TeePeeTest : GHAsyncTestCase { 
}



@end

@implementation TeePeeTest



- (void)setup
{

}

- (void)testWithStrings
{
  TeePee *tp  = [[TeePee alloc] initWithDelegate:self];
  [tp get:@"/" foo:@"bar" bar:@"hoge" onSuccess:@"didLoad:" onFailure:@"didFail:"];
}

- (void)testWithArray
{
  TeePee *tp  = [[TeePee alloc] initWithDelegate:self];
  NSArray *opts = [NSArray arrayWithObjects:@"one",@"two",nil];
  [tp get:@"/" foo:@"bar" bar:opts onSuccess:@"didLoad:" onFailure:@"didFail:"];
}

- (void)testWithDictionary
{
  TeePee *tp  = [[TeePee alloc] initWithDelegate:self];
  NSDictionary *opts = [NSDictionary dictionaryWithObjectsAndKeys:@"one",@"foo",@"two",@"bar",nil];
  [tp get:@"/" bar:opts onSuccess:@"didLoad:" onFailure:@"didFail:"];
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