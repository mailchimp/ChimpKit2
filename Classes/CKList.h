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
           doubleOptIn:(NSString*)optIn 
        updateExisting:(NSString*)update 
      replaceInterests:(NSString*)replace;

- (void)batchUnsubscribe:(NSString*)listId 
                  emails:(NSArray*)emails 
            deleteMember:(NSString*)deleteMember 
             sendGoodbye:(NSString*)goodbye 
              sendNotify:(NSString*)notify;

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
      sendWelcome:(NSString*)welcome;

- (void)unsubscribe:(NSString*)listId 
          withEmail:(NSString*)email 
       deleteMember:(NSString*)deleteMember
        sendGoodbye:(NSString*)goodbye
         sendNotify:(NSString*)notify;

- (void)findAll;

@end

@interface CKList(Squelch)
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId start:(NSNumber *)start limit:(NSNumber *)limit since:(NSString*)since;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId double_optin:(NSString*)optIn update_existing:(NSString*)update replace_interests:(NSString*)replace;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId email:(NSArray *)email delete_member:(NSString*)del send_goodbye:(NSString*)goodbye send_notify:(NSString*)notify;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId group_name:(NSString *)name;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId old_name:(NSString *)old new_name:(NSString*)newName;
- (void)get:(NSString *)path method:(NSString *)methodName email_address:(NSString*)email;
- (void)get:(NSString *)path method:(NSString *)methodName status:(NSString *)status since:(NSString*)since start:(NSString*)start limit:(NSString*)limit;
- (void)get:(NSString *)path method:(NSString *)methodName id:(NSString *)listId merge_vars:(NSString*)vars email_address:(NSString*)email send_welcome:(NSString*)welcome;
- (void)get:(NSString *)path method:(NSString *)methodName;
- (void)get:(NSString *)path method:(NSString *)methodName email_address:(NSString *)email delete_member:(NSString*)deleteMember send_goodbye:(NSString*)goodbye send_notify:(NSString*)notify;

@end

