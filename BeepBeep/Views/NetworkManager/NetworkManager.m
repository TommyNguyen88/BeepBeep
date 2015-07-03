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
        _sharedClient = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:BBBaseURL]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        self.securityPolicy.allowInvalidCertificates = YES;
//        [self.requestSerializer setAuthorizationHeaderFieldWithUsername:username password:password];
    }
    
    return self;
}

#pragma mark - Base functions

- (void)callWebserviceWithPath:(NSString *)path
                        method:(NSString *)method
                    parameters:(NSDictionary *)parameters
                    completion:(void (^) (MAResponseObject *responseObject))completion {
    NSMutableURLRequest *request = [self requestWithMethod:method parameters:parameters path:path];
    
    if (request) {
        [request setTimeoutInterval:BBNetWorkTimeOutInterval];
        AFHTTPRequestOperation *operation  =  [self operationForRequest:request completion:completion];
        if (operation != nil) {
            [[NetworkManager sharedManager].operationQueue addOperation:operation];
        }
    }
}

/**
 Create request for special method, parameters and path
 @param method The HTTP method for the request
 @param parameters The parameters that will be include to the request
 @param path The url for the request
 */
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                parameters:(NSDictionary *)parameters
                                      path:(NSString *)path {
    NSError *error;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method
                                                                   URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString]
                                                                  parameters:[self fullAPIParameters:parameters]
                                                                       error:&error];
    
    if (error) {
        DLog(@"Unresolve error: %@", error.userInfo);
        abort();
    }
    
    DLog(@"----------------------");
    DLog(@"Path:%@ \n Body params: %@ \n", path, [self fullAPIParameters:parameters]);
    DLog(@"----------------------");
    [request setTimeoutInterval:BBNetWorkTimeOutInterval];
    return request;
}

- (AFHTTPRequestOperation *)operationForRequest:(NSMutableURLRequest *)request completion:(void (^) (MAResponseObject *responseObject))completion {
    if (request == nil) {
        DLog(@"Request cannot be nil @@!");
        abort();
    }
    return [self HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        MAResponseObject *responseObj = [MAResponseObject responseObjectWithRequestOperation:operation error:nil];
        if (completion) {
            completion(responseObj);
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        MAResponseObject *responseObj = [MAResponseObject responseObjectWithRequestOperation:operation error:error];
        if (completion) {
            completion(responseObj);
        }
    }];
}

- (NSDictionary *)fullAPIParameters:(NSDictionary *)parameters {
    NSMutableDictionary *mParams = parameters ? parameters.mutableCopy : @{}.mutableCopy;
    //    [mParams setObject:[[RDSession sharedSession] accessToken] forKey:kAPIKeyAccessToken];
    return mParams;
}

#pragma mark - Authentication

- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(MAResponseObject *))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSDictionary *parameters = @{
                                 @"grant_type": @"password",
                                 @"username": username,
                                 @"password": password
                                 };
    
    NSError *error;
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:[BBBaseURL stringByAppendingString:@"/oauth/token"] parameters:parameters error:&error];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSInteger code = [[responseObject objectForKey:BBResCode] integerValue];
        
        if (code == 0) {
            id accessToken = [responseObject objectForKey:BBResAccesToken];
            id tokenType = [responseObject objectForKey:BBResTokenType];
            
            NSLog(@"Success: %@ -- %@", accessToken, tokenType);
        }
        else {
            NSString *str = @"Sign in failed!";
            switch (code) {
                case 400:
                    str = NSLocalizedString(@"Bad Parameters", nil);
                    break;
                    
                case 401:
                    str = NSLocalizedString(@"Unauthorized", nil);
                    break;
                    
                case 402:
                    str = NSLocalizedString(@"Payment Required", nil);
                    break;
                    
                case 403:
                    str = NSLocalizedString(@"Forbidden", nil);
                    break;
                    
                case 404:
                    str = NSLocalizedString(@"Not Found", nil);
                    break;
                    
                case 500:
                    str = NSLocalizedString(@"Internal Server Error", nil);
                    break;
                    
                case 501:
                    str = NSLocalizedString(@"Not Implemented", nil);
                    break;
                    
                default:
                    break;
            }
        }
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Failure: %@", error);
    }];
    
    [manager.operationQueue addOperation:operation];
}

@end
