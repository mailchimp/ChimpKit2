//
//  CKDialogController.h
//  CKDialog
//
//  Created by Christopher Burnett on 2/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKList.h"

@interface CKDialogController : UIViewController <UITextFieldDelegate> {
  UITextField *emailInput;
  UIButton    *signupBtn;
  UIButton    *closeBtn;
  UIView      *dialog;
  CKList      *list;
  NSString    *listID;
  SEL         onSuccess;
  SEL         onFailure;
  id          delegate;
}

@property(nonatomic,retain) IBOutlet UITextField *emailInput;
@property(nonatomic,retain) IBOutlet UIButton    *signupBtn;
@property(nonatomic,retain) IBOutlet UIButton    *closeBtn;
@property(nonatomic,retain) IBOutlet UIView      *dialog;
@property(nonatomic,retain) CKList    *list;
@property(nonatomic,retain) NSString  *listID;
@property(assign,readwrite) id delegate;
@property(assign,readwrite) SEL onSuccess;
@property(assign,readwrite) SEL onFailure;

- (id)initWithDelegate:(id)aDelegate;
- (IBAction)signupEmailAddress:(id)sender;
- (void)show;
- (void)removeDialog:(id)sender;
- (IBAction)dismissDialog:(id)sender;
- (void)cleanupViews:(id)sender;
- (void)textEntryDefaults;
- (void)dialogDefaults;
- (UIView*)window;
- (void)startBounceTwo;
- (void)stopBouncing;
- (void)performSignup;

@end
