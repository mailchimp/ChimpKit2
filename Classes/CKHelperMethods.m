//
//  CKHelperMethods.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import "CKHelperMethods.h"


@implementation CKHelperMethods

- (void)chimpChatter
{
  [self get:@"/" method:@"chimpChatter"];
  
}

- (void)creeateFolder:(NSString*)name
{
  [self get:@"/" method:@"createFolder"];

}
- (void)generateText:(NSString*)type 
         fromContent:(NSString*)content
{
  [self get:@"/" method:@"generateText" type:type content:content];
}
- (void)getAccountDetails
{
  [self get:@"/" method:@"getAccountDetails"];
}
- (void)inlineCss:(NSString*)html 
         stripCss:(NSString*)strip
{
  [self get:@"/" method:@"inlineCss" html:html strip_css:strip];
}
- (void)ping
{
  [self get:@"/" method:@"ping"];
}

@end
