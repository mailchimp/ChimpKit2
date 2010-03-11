//
//  Campaign.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CKCampaign : NSObject { }

- (void)content:(NSString*)campaignId 
     forArchive:(BOOL)archive;

- (void)createCampaign:(NSString*)type 
   withOptions:(NSDictionary*)options 
       content:(NSString*)content 
segmentOptions:(NSDictionary*)segOptions 
   typeOptions:(NSDictionary*)typeOpts;

- (void)update:(NSString*)campaingId 
     fieldName:(NSString*)name 
    fieldValue:(NSString*)value;

- (void)deleteCampaign:(NSString*)campaignId;
- (void)folders:(NSString*)campaignId;
- (void)pause:(NSString*)campaignId;
- (void)replicate:(NSString*)campaignId;
- (void)resume:(NSString*)campaignId;
- (void)sendNow:(NSString*)campaignId;
- (void)unschedule:(NSString*)campaignId;
- (void)templates;

- (void)schedule:(NSString*)campaignId 
         forTime:(NSString*)time 
         andTime:(NSString*)timeb;

- (void)findAllfilteredBy:(NSDictionary*)filters 
               startingAt:(NSNumber*)start 
                withLimit:(NSNumber*)limit;

@end

@interface CKCampaign(Squelch)
- (void)get:(NSString *)path method:(NSString *)methodName cid:(NSString*)cid for_archive:(BOOL)archive;
- (void)get:(NSString *)path method:(NSString *)methodName type:(NSString*)type options:(NSDictionary*)opts content:(NSString*)content segment_opts:(NSDictionary*)segOpts type_opts:(NSDictionary*)typeOpts;
- (void)get:(NSString *)path method:(NSString *)methodName cid:(NSString *)cid name:(NSString*)name value:(NSString*)value;
- (void)get:(NSString *)path method:(NSString *)methodName cid:(NSString *)cid;
- (void)get:(NSString *)path method:(NSString *)methodName;
- (void)get:(NSString *)path method:(NSString *)methodName cid:(NSString *)cid schedule_time:(NSString*)time schedule_time_b:(NSString*)timeB;
- (void)get:(NSString *)path method:(NSString *)methodName filters:(NSDictionary *)filters start:(NSNumber*)start limit:(NSNumber*)limit;
@end
