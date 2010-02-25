//
//  SampleController.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/23/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "SampleController.h"
#import "CKDialogController.h"

@implementation SampleController

- (IBAction)showDialog
{
  [ChimpKit setAPIKey:@"1df3dda132dc2338706decdd08198719-us1"];
  
  CKDialogController *dialog = [[CKDialogController alloc] initWithDelegate:self];

  dialog.listID     = @"e892b61220";  
  dialog.onSuccess  = @selector(signupDidSucceed:);
  dialog.onFailure  = @selector(signupDidFail:);
  
  [dialog show];
}

- (void)signupDidSucceed:(id)data
{
  UIAlertView *alert	= [[UIAlertView alloc] initWithTitle:nil 
                                                  message:@"You have been signed up."
                                                 delegate:self 
                                        cancelButtonTitle:@"OK" 
                                        otherButtonTitles:nil]; 
  [alert show]; 
  [alert release];
}

- (void)signupDidFail:(id)data
{
  UIAlertView *alert	= [[UIAlertView alloc] initWithTitle:nil 
                                                  message:[data objectForKey:@"error"]
                                                 delegate:self 
                                        cancelButtonTitle:@"OK" 
                                        otherButtonTitles:nil]; 
  [alert show]; 
  [alert release];
}

- (BOOL)validateEmailAddress:(NSString*)address
{
  return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
