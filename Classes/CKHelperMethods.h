//
//  CKHelperMethods.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChimpKit.h"

@interface CKHelperMethods : ChimpKit {

}
+ (void)creeateFolder:(NSString*)name;
+ (void)generateText:(NSString*)type fromContent:(NSString*)content;
+ (void)getAccountDetails;
+ (void)inlineCss:(NSString*)html stripCss:(BOOL)strip;
+ (void)ping;
@end
