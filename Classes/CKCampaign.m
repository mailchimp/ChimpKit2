//
//  Campaign.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import "CKCampaign.h"


@implementation CKCampaign

- (void)content:(NSString*)campaignId forArchive:(NSString*)archive
{
  [self get:@"/" method:@"campaignContent" cid:campaignId for_archive:archive];

}

- (void)createCampaign:(NSString*)type 
           withOptions:(NSDictionary*)options 
               content:(NSString*)content 
        segmentOptions:(NSDictionary*)segOptions 
           typeOptions:(NSDictionary*)typeOpts
{
  [self get:@"/" method:@"campaignCreate" type:type options:options content:content segment_opts:segOptions type_opts:typeOpts];
}

- (void)update:(NSString*)campaingId 
     fieldName:(NSString*)name 
    fieldValue:(NSString*)value
{
  [self get:@"/" method:@"campaignUpdate" cid:campaingId name:name value:value];
}

- (void)deleteCampaign:(NSString*)campaignId
{
  [self get:@"/" method:@"campaignDelete" cid:campaignId];
}
- (void)folders:(NSString*)campaignId
{
  [self get:@"/" method:@"campaignFolders"]; 
}
- (void)pause:(NSString*)campaignId
{
  [self get:@"/" method:@"campaignPause"];
}
- (void)replicate:(NSString*)campaignId
{
  [self get:@"/" method:@"campaignReplicate" cid:campaignId];
}
- (void)resume:(NSString*)campaignId
{
  [self get:@"/" method:@"campaignResume" cid:campaignId];
}
- (void)sendNow:(NSString*)campaignId
{
  [self get:@"/" method:@"campaignSendNow" cid:campaignId];
}
- (void)unschedule:(NSString*)campaignId
{
  [self get:@"/" method:@"campaignUnschedule" cid:campaignId];
}
- (void)templates
{
  [self get:@"/" method:@"campaignTemplates"];
}

- (void)schedule:(NSString*)campaignId 
         forTime:(NSString*)time 
         andTime:(NSString*)timeb
{
  [self get:@"/" method:@"campaignSchedule" cid:campaignId schedule_time:time schedule_time_b:timeb]; 
}

- (void)findAllfilteredBy:(NSDictionary*)filters 
               startingAt:(NSNumber*)start 
                withLimit:(NSNumber*)limit
{
  [self get:@"/" method:@"campaigns" filters:filters start:start limit:limit];
}

- (void)getGeoOpens:(NSString *)campaignId 
{
    [self get:@"/" method:@"campaignGeoOpens" cid:campaignId];
}


@end
