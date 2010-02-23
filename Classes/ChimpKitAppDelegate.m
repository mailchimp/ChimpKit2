//
//  ChimpKitAppDelegate.m
//  ChimpKit
//
//  Created by Christopher Burnett on 1/28/10.
//  Copyright twoism 2010. All rights reserved.
//

#import "ChimpKitAppDelegate.h"
#import "CKDialogController.h"

@implementation ChimpKitAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  [window makeKeyAndVisible];
}


- (void)dealloc {
  [window release];
  [super dealloc];
}


- (IBAction)showDialog
{
  CKDialogController *dialog = [[CKDialogController alloc] initWithDelegate:self];
  
  dialog.onSuccess = @selector(signupDidSucceed:);
  dialog.onFailure = @selector(signupDidFail:);
  
  [dialog show];
}

- (void)signupDidSucceed:(id)data
{
  NSLog(@"sucess!!");
}

- (void)signupDidFail:(id)data
{
  NSLog(@"fail!!");
}

- (BOOL)validateEmailAddress:(NSString*)address
{
  if ([address isEqualToString:@"me@me.com"]) {
    return YES;
  }else{
    return NO;
  }
}


@end
