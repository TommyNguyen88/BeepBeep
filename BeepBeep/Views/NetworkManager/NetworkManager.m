//
//  NetworkManager.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/23/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "NetworkManager.h"

@implementation NetworkManager


+ (instancetype)sharedManager {
    static NetworkManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NetworkManager alloc] init];
    });
    
    return _sharedClient;
}

- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    [manager.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    
    NSDictionary *parameters = @{
                                 @"grant_type": @"password",
                                 @"username": username,
                                 @"password": password
                                 };
    
    NSError *error;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:[BBBaseURL stringByAppendingString:@"/oauth/token"] parameters:parameters error:&error];
    
    //[request setValue:@"password" forHTTPHeaderField:@"grant_type"];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [[responseObject objectForKey:BBResCode] integerValue];

        if (code == 0) {
            id responseData = [responseObject objectForKey:BBResData];
            NSLog(@"Success: %@", responseData);
            
            if ([self.delegate respondsToSelector:@selector(smDidSignInWithUsername:andPassword:error:)]) {
                [self.delegate smDidSignInWithUsername:username andPassword:password error:nil];
            }
        }
        else{
            NSString *str = @"Sign in failed!";
            switch (code) {
                case 200:
                    str = NSLocalizedString(@"ERROR_CODE_19", nil);
                    break;
                case 201:
                    str = NSLocalizedString(@"ERROR_CODE_15", nil);
                    break;
                case 400:
                    str = NSLocalizedString(@"ERROR_CODE_99", nil);
                    break;
                default:
                    break;
            }
            [self.delegate smDidSignInWithUsername:nil andPassword:nil error:[[MARequestErrorInfo alloc] initWithCode:code description:[error description]]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
        if ([self.delegate respondsToSelector:@selector(smDidSignInWithUsername:andPassword:error:)]) {
            [self.delegate smDidSignInWithUsername:username andPassword:password error:[[MARequestErrorInfo alloc] initWithCode:4.0 description:[error description]]];
        }
    }];
    
    [manager.operationQueue addOperation:operation];
}

@end
