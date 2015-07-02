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

@property (nonatomic, strong) id<NetworkManagerDelegate> delegate;
/**-----------------------------------------------------------------**/
#pragma mark - Authentication

- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
