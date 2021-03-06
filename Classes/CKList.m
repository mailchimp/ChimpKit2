//
//  CKList.m
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import "CKList.h"


@implementation CKList

- (void)abuseReports:(NSString*)listId 
          startingAt:(NSNumber*)start 
           withLimit:(NSNumber*)limit
           sinceDate:(NSString*)since
{
  [self get:@"/" method:@"listAbuseReports" id:listId start:start limit:limit since:since];
}

- (void)batchSubscribe:(NSString*)listId 
             withBatch:(NSArray*)batch 
           doubleOptIn:(NSString*)optIn 
        updateExisting:(NSString*)update 
      replaceInterests:(NSString*)replace
{
  [self get:@"/" method:@"listBatchSubscribe" id:listId double_optin:optIn update_existing:update replace_interests:replace];
}

- (void)batchUnsubscribe:(NSString*)listId 
                  emails:(NSArray*)emails 
            deleteMember:(NSString*)deleteMember 
             sendGoodbye:(NSString*)goodbye 
              sendNotify:(NSString*)notify
{
  [self get:@"/" method:@"listBatchUnsubscribe" id:listId email:emails delete_member:deleteMember send_goodbye:goodbye send_notify:notify];
}

- (void)growthHistory:(NSString*)listId
{
  [self get:@"/" method:@"listGrowthHistory" id:listId];
}

- (void)interestGroupAdd:(NSString*)listId 
               groupName:(NSString*)name
{
  [self get:@"/" method:@"listInterestGroupAdd" id:listId group_name:name];  
}

- (void)interestGroupDelete:(NSString*)listId 
                  groupName:(NSString*)name
{
  [self get:@"/" method:@"listInterestGroupDelete" id:listId group_name:name];
}

- (void)interestGroupUpdate:(NSString*)listId 
                    oldName:(NSString*)oldName 
                    newName:(NSString*)newName
{
  [self get:@"/" method:@"listInterestGroupUpdate" id:listId old_name:oldName new_name:newName];
}

- (void)interestGroups:(NSString*)listId
{
  [self get:@"/" method:@"listInterestGroups" id:listId];
}

- (void)memberInfo:(NSString*)listId 
          forEmail:(NSString*)email
{
  [self get:@"/" method:@"listMemberInfo" id:listId email_address:email];
}

- (void)listMembers:(NSString*)listId {
	[self get:@"/" 
	   method:@"listMembers" 
		   id:listId];
}

- (void)listMembers:(NSString*)listId 
         withStatus:(NSString*)status 
          sinceDate:(NSString*)since 
         startingAt:(NSNumber*)start 
          withLimit:(NSNumber*)limit
{
  [self get:@"/" 
     method:@"listMembers" 
		 id:listId 
     status:status 
      since:since 
      start:[start stringValue] 
      limit:[limit stringValue]];
}

- (void)subscribe:(NSString*)listId 
        withEmail:(NSString*)email 
      sendWelcome:(NSString*)welcome
      doubleOptIn:(NSString*)optIn
{
    [self get:@"/" method:@"listSubscribe" id:listId merge_vars:@"" email_address:email send_welcome:welcome double_optin:optIn];
}

- (void)unsubscribe:(NSString*)listId 
          withEmail:(NSString*)email 
       deleteMember:(NSString*)deleteMember
        sendGoodbye:(NSString*)goodbye
         sendNotify:(NSString*)notify
{
  [self get:@"/" method:@"listUnsubscribe" email_address:email delete_member:deleteMember send_goodbye:goodbye send_notify:notify];
}

- (void)findAll
{
  [self get:@"/" method:@"lists"];
}

@end
