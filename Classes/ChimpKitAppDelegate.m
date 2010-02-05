//
//  ChimpKitAppDelegate.m
//  ChimpKit
//
//  Created by Christopher Burnett on 1/28/10.
//  Copyright twoism 2010. All rights reserved.
//

#import "ChimpKitAppDelegate.h"

@implementation ChimpKitAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
