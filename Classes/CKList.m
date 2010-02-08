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
  
}

- (void)batchSubscribe:(NSString*)listId 
             withBatch:(NSArray*)batch 
           doubleOptIn:(BOOL)optIn 
        updateExisting:(BOOL)update 
      replaceInterests:(BOOL)replace
{
  
}

- (void)batchUnsubscribe:(NSString*)listId 
                  emails:(NSArray*)emails 
            deleteMember:(BOOL)deleteMember 
             sendGoodbye:(BOOL)goodbye 
              sendNotify:(BOOL)notify
{
  
}

- (void)growthHistory:(NSString*)listId
{
  
}

- (void)interestGroupAdd:(NSString*)listId 
               groupName:(NSString*)name
{
  
}

- (void)interestGroupDelete:(NSString*)listId 
                    groupId:(NSString*)groupId 
                  groupName:(NSString*)name
{
  
}

- (void)interestGroupUpdate:(NSString*)listId 
                    groupId:(NSString*)groupId 
                    oldName:(NSString*)oldName 
                    newName:(NSString*)newName
{
  
}

- (void)interestGroups:(NSString*)listId
{
  [self get:@"/" method:@"listInterestGroups" id:listId];
}

- (void)memberInfo:(NSString*)listId 
          forEmail:(NSString*)email
{
  [self get:@"/" method:@"listMemberInfo" email_address:email];
}

- (void)listMembers:(NSString*)listId 
         withStatus:(NSString*)status 
          sinceDate:(NSString*)since 
         startingAt:(NSNumber*)start 
          withLimit:(NSNumber*)limit
{
  [self get:@"/" 
     method:@"listMembers" 
     status:status 
      since:since 
      start:[start stringValue] 
      limit:[limit stringValue]];
}

- (void)subscribe:(NSString*)listId 
        withEmail:(NSString*)email 
        mergeVars:(NSArray*)vars 
        emailType:(NSString*)type 
      doubleOptin:(BOOL)optin 
   updateExisting:(BOOL)update 
 replaceInterests:(BOOL)replace 
      sendWelcome:(BOOL)welcome
{
  [self get:@"/" method:@"listSubscribe"
          email_address:email
             merge_vars:vars
             email_type:type
           double_optin:optin
        update_existing:update
      replace_interests:replace
           send_welcome:welcome];
}

- (void)unsubscribe:(NSString*)listId 
          withEmail:(NSString*)email 
       deleteMember:(BOOL)deleteMember
        sendGoodbye:(BOOL)goodbye
         sendNotify:(BOOL)notify
{
  [self get:@"/" 
     method:@"listUnsubscribe" 
email_address:email 
delete_member:deleteMember
send_goodbye:goodbye
send_notify:notify];
}

- (void)findAll
{
  NSLog(@"made it");
  [self get:@"/" method:@"lists"];
}

@end
