//
//  CKList.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChimpKit.h"

@interface CKList : ChimpKit { }

- (void)abuseReports:(NSString*)listId 
          startingAt:(NSNumber*)start 
           withLimit:(NSNumber*)limit
           sinceDate:(NSString*)since;

- (void)batchSubscribe:(NSString*)listId 
             withBatch:(NSArray*)batch 
           doubleOptIn:(BOOL)optIn 
        updateExisting:(BOOL)update 
      replaceInterests:(BOOL)replace;

- (void)batchUnsubscribe:(NSString*)listId 
                  emails:(NSArray*)emails 
            deleteMember:(BOOL)deleteMember 
             sendGoodbye:(BOOL)goodbye 
              sendNotify:(BOOL)notify;

- (void)growthHistory:(NSString*)listId;

- (void)interestGroupAdd:(NSString*)listId 
               groupName:(NSString*)name;

- (void)interestGroupDelete:(NSString*)listId  
                  groupName:(NSString*)name;

- (void)interestGroupUpdate:(NSString*)listId 
                    oldName:(NSString*)oldName 
                    newName:(NSString*)newName;

- (void)interestGroups:(NSString*)listId;

- (void)memberInfo:(NSString*)listId 
          forEmail:(NSString*)email;

- (void)listMembers:(NSString*)listId 
         withStatus:(NSString*)status 
          sinceDate:(NSString*)since 
         startingAt:(NSNumber*)start 
          withLimit:(NSNumber*)limit;


- (void)subscribe:(NSString*)listId 
        withEmail:(NSString*)email 
      sendWelcome:(BOOL)welcome;

- (void)unsubscribe:(NSString*)listId 
          withEmail:(NSString*)email 
       deleteMember:(BOOL)deleteMember
        sendGoodbye:(BOOL)goodbye
         sendNotify:(BOOL)notify;

- (void)findAll;

@end

@interface CKList(Squelch)
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId start:(NSNumber *)start limit:(NSNumber *)limit since:(NSString*)since;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId double_optin:(BOOL)optIn update_existing:(BOOL)update replace_interests:(BOOL)replace;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId email:(NSArray *)email delete_member:(BOOL)del send_goodbye:(BOOL)goodbye send_notify:(BOOL)notify;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId group_name:(NSString *)name;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId old_name:(NSString *)old new_name:(NSString*)newName;
- (void)get:(NSString *)path method:(NSString *)methodName email_address:(NSString*)email;
- (void)get:(NSString *)path method:(NSString *)methodName status:(NSString *)status since:(NSString*)since start:(NSString*)start limit:(NSString*)limit;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId merge_vars:(NSString*)vars email_address:(NSString*)email send_welcome:(BOOL)welcome;
- (void)get:(NSString *)path method:(NSString *)methodName;
- (void)get:(NSString *)path method:(NSString *)methodName email_address:(NSString *)email delete_member:(BOOL)deleteMember send_goodbye:(BOOL)goodbye send_notify:(BOOL)notify;

@end

