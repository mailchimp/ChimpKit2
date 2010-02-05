//
//  CKList.h
//  ChimpKit
//
//  Created by Christopher Burnett on 2/1/10.
//  Copyright 2010 twoism. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChimpKit.h"

@interface CKList : ChimpKit {

}

+ (void)abuseReports:(NSString*)listId 
          startingAt:(NSNumber*)start 
           withLimit:(NSNumber*)limit
           sinceDate:(NSString*)since;

+ (void)batchSubscribe:(NSString*)listId 
             withBatch:(NSArray*)batch 
           doubleOptIn:(BOOL)optIn 
        updateExisting:(BOOL)update 
      replaceInterests:(BOOL)replace;

+ (void)batchUnsubscribe:(NSString*)listId 
                  emails:(NSArray*)emails 
            deleteMember:(BOOL)deleteMember 
             sendGoodbye:(BOOL)goodbye 
              sendNotify:(BOOL)notify;

+ (void)growthHistory:(NSString*)listId;

+ (void)interestGroupAdd:(NSString*)listId 
               groupName:(NSString*)name;

+ (void)interestGroupDelete:(NSString*)listId 
                    groupId:(NSString*)groupId 
                  groupName:(NSString*)name;

+ (void)interestGroupUpdate:(NSString*)listId 
                    groupId:(NSString*)groupId 
                    oldName:(NSString*)oldName 
                    newName:(NSString*)newName;

+ (void)interestGroups:(NSString*)listId;

+ (void)memberInfo:(NSString*)listId 
          forEmail:(NSString*)email;

+ (void)listMembers:(NSString*)listId 
         withStatus:(NSString*)status 
          sinceDate:(NSString*)since 
         startingAt:(NSNumber*)start 
          withLimit:(NSNumber*)limit;

+ (void)mergerVarAdd:(NSString*)listId 
              forTag:(NSString*)tag 
            withName:(NSString*)name 
             withReq:(NSDictionary*)req;

+ (void)mergeVarDelete:(NSString*)listId 
                forTag:(NSString*)tag 
           withOptions:(NSDictionary*)options;

+ (void)subscribe:(NSString*)listId 
        withEmail:(NSString*)email 
        mergeVars:(NSArray*)vars 
        emailType:(NSString*)type 
      doubleOptin:(BOOL)optin 
   updateExisting:(BOOL)update 
 replaceInterests:(BOOL)replace 
      sendWelcome:(BOOL)welcome;

+ (void)unsubscribe:(NSString*)listId 
          withEmail:(NSString*)email 
       deleteMember:(BOOL)deleteMember
        sendGoodbye:(BOOL)goodbye
         sendNotify:(BOOL)notify;

+ (void)findAll;

@end
