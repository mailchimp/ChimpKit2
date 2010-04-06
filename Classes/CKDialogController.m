//
//  CKDialogController.m
//  CKDialog
//
//  Created by Christopher Burnett on 2/22/10.
//  Copyright 2010 Apple Inc. All rights reserved.
//

#import "CKDialogController.h"


static CGFloat bounceDuration = 0.4;

@implementation CKDialogController

@synthesize dialog, closeBtn, signupBtn, emailInput, onSuccess, onFailure, delegate, list, listID;


- (void)dealloc 
{
  delegate = NULL;
  [super dealloc];
}

- (id)initWithDelegate:(id)aDelegate
{
  self = [super init];
  if (self != nil) {
    [self initWithNibName:@"CKDialog" 
                   bundle:nil];
    self.delegate = aDelegate;
  }
  return self;
}

- (void)viewDidLoad 
{
  [self dialogDefaults];
  [self textEntryDefaults];
  [super viewDidLoad];
}

- (void)dialogDefaults
{
  self.dialog.alpha = 0.0;
}

- (void)textEntryDefaults
{
  self.signupBtn.enabled        = NO;
  self.emailInput.text          = @"";
  self.emailInput.placeholder   = @"Enter an email address.";
  self.emailInput.keyboardType  = UIKeyboardTypeEmailAddress;
  self.emailInput.returnKeyType = UIReturnKeySend;
  self.emailInput.delegate      = self;
}

- (void)show
{
  
  [[self window] addSubview:self.view];
  
  self.dialog.transform = CGAffineTransformScale(CGAffineTransformIdentity, 3, 3);
  
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:bounceDuration/1.0];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(startBounceTwo)];
    self.dialog.transform = CGAffineTransformScale(CGAffineTransformIdentity, 3, 3);
    
  [UIView commitAnimations];
  
}

- (void)startBounceTwo 
{
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:bounceDuration/1.5];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(stopBouncing)];
  [self.dialog setAlpha:1.0];
    self.dialog.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
  [UIView commitAnimations];
}

- (void)stopBouncing 
{
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:bounceDuration/2];
    self.dialog.transform = CGAffineTransformIdentity;
  [UIView commitAnimations];
}

- (void)cleanupViews:(id)sender
{
  [self.view removeFromSuperview];
}

- (void)removeDialog:(id)sender
{
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.3];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(cleanupViews:)];
    [self.view setAlpha:0.0];
  [UIView commitAnimations];
}

- (IBAction)dismissDialog:(id)sender
{
  [UIView beginAnimations:nil context:nil];
  [UIView setAnimationDuration:0.3];
  [UIView setAnimationDelegate:self];
  [UIView setAnimationDidStopSelector:@selector(removeDialog:)];
    [self.dialog setAlpha:0.0];
  [UIView commitAnimations];
}

- (IBAction)signupEmailAddress:(id)sender
{
  BOOL valid = YES;

  if ([self.delegate respondsToSelector:@selector(validateEmailAddress:)]) {
    valid = (BOOL)[self.delegate performSelector:@selector(validateEmailAddress:) 
                                      withObject:emailInput.text];
  }
  NSLog(@"fooo");
  if (valid) {
    [self performSignup];
  }else {
    NSLog(@"email is invalid!");
  }
  
}

- (void)performSignup
{
  self.signupBtn.enabled = NO;
  [self dismissDialog:nil];

  
  list            = [[CKList alloc] initWithDelegate:delegate];
  list.onFailure  = self.onSuccess;
  list.onSuccess  = self.onFailure;
  
  [list subscribe:self.listID 
        withEmail:self.emailInput.text 
      sendWelcome:NO];
}

- (UIView*)window
{
  UIWindow* window = [UIApplication sharedApplication].keyWindow;
  if (!window) {
    window = [[UIApplication sharedApplication].windows objectAtIndex:0];
  }
  return window;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
  return NO;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  if ([textField.text length] > 1) {
    self.signupBtn.enabled = YES;
  }else {
    self.signupBtn.enabled = NO;
  }
  return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
  self.signupBtn.enabled = NO;
  
  [self.emailInput resignFirstResponder];
  [self performSelector:@selector(dismissDialog:)  
             withObject:nil 
             afterDelay:0.3];
  
  return YES;
}

@end
