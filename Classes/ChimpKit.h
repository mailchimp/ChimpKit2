//
//  ChimpKit.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChimpKit.h"

@interface ChimpKit : NSObject {
	id delegate;
	NSOperationQueue *requestQueue;
}

@property (nonatomic, readwrite) id delegate;
@property (nonatomic,retain) NSOperationQueue *requestQueue;



@end
