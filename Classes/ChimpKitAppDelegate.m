//
//  ChimpKitAppDelegate.m
//  ChimpKit
//
//  Created by Christopher Burnett on 1/28/10.
//  Copyright twoism 2010. All rights reserved.
//

#import "ChimpKitAppDelegate.h"
#import "SampleController.h"

@implementation ChimpKitAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
  
  SampleController *controller = [[SampleController alloc] initWithNibName:@"SampleController" bundle:nil];
  
  [window addSubview:controller.view];
  
  [window makeKeyAndVisible];
}


- (void)dealloc {
  [window release];
  [super dealloc];
}

@end
