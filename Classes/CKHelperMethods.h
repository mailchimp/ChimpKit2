//
//  CKHelperMethods.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChimpKit.h"

@interface CKHelperMethods : ChimpKit { }
- (void)chimpChatter;
- (void)creeateFolder:(NSString*)name;
- (void)generateText:(NSString*)type fromContent:(NSString*)content;
- (void)getAccountDetails;
- (void)inlineCss:(NSString*)html stripCss:(NSString*)strip;
- (void)ping;
- (void)loginWithUsername:(NSString*)username 
              andPassword:(NSString*)password;
@end

@interface CKHelperMethods(Squelch)
- (void)get:(NSString*)path method:(NSString*)methodName;
- (void)get:(NSString*)path method:(NSString*)methodName type:(NSString*)type content:(NSString*)content;
- (void)get:(NSString*)path method:(NSString*)methodName html:(NSString*)html strip_css:(NSString*)strip;
- (void)get:(NSString*)path method:(NSString*)methodname username:(NSString*)username password:(NSString*)password;
@end

