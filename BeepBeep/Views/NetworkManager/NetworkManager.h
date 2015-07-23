//
//  NetworkManager.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/23/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "MAResponseObject.h"
#import "RDSession.h"
#import "DataManager.h"

@interface NetworkManager : AFHTTPRequestOperationManager

+ (instancetype)sharedManager;

/**-----------------------------------------------------------------**/
#pragma mark - Authentication

- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^) (MAResponseObject *responseObject))completion;
- (void)signOutWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^) (MAResponseObject *responseObject))completion;

#pragma mark - List Jobs
- (void)getListJobsWithCompletion:(void (^) (MAResponseObject *responseObject))completion;

@end
