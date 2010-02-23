//
//  ChimpKitAppDelegate.h
//  ChimpKit
//
//  Created by Christopher Burnett on 1/28/10.
//  Copyright twoism 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChimpKitAppDelegate : NSObject <UIApplicationDelegate,UITextFieldDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)showDialog;
- (BOOL)validateEmailAddress:(NSString*)address;
- (void)signupDidSucceed:(id)data;
- (void)signupDidFail:(id)data;

@end

