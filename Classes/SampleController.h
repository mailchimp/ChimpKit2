//
//  SampleController.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/23/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SampleController : UIViewController {

}

- (IBAction)showDialog;
- (BOOL)validateEmailAddress:(NSString*)address;
- (void)signupDidSucceed:(id)data;
- (void)signupDidFail:(id)data;

@end
