//
//  NetworkManager.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/23/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "MARequestErrorInfo.h"

@protocol NetworkManagerDelegate <NSObject>
@optional

- (void)smDidOAuthWithToken:(NSString *)token expiresIn:(NSInteger)time error:(MARequestErrorInfo *)error;

- (void)smDidSignInWithUsername:(NSString *)username andPassword:(NSString *)password error:(MARequestErrorInfo *)error;

@end

@interface NetworkManager : AFHTTPRequestOperationManager

+ (instancetype)sharedManager;

/**-----------------------------------------------------------------**/
#pragma mark - Authentication

- (void)signUpWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
