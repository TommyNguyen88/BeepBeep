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
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"Configurations" ofType:@"plist"];
        NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        NSString *hostInfo = [config objectForKey:@"host"];
        
        hostInfo = [hostInfo stringByAppendingString:BBApiSignIn];

        _sharedClient = [[NetworkManager alloc] initWithBaseURL:[NSURL URLWithString:hostInfo]];
    });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    
    if (self) {
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        self.securityPolicy.allowInvalidCertificates = YES;
    }
    
    return self;
}

- (NSDictionary *)fullAPIParameters:(NSDictionary *)parameters {
    NSMutableDictionary *mParams = parameters ? parameters.mutableCopy : @{}.mutableCopy;
    //[mParams setObject:[[RDSession sharedSession] accessToken] forKey:BBResAccesToken];
    return mParams;
}

#pragma mark - Authentication

- (void)callWebserviceWithPath:(NSString *)path
                        method:(NSString *)method
                   headerField:(NSString *)authorization
                    parameters:(NSDictionary *)parameters
                    completion:(void (^) (MAResponseObject *responseObject))completion {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    if (authorization != NULL) {
        [manager.requestSerializer setValue:authorization forHTTPHeaderField:@"Authorization"];
    }
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSError *error;
    
    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:method URLString:path parameters:parameters error:&error];
    
    [request setTimeoutInterval:BBNetWorkTimeOutInterval];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
    
    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
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
    
    if (operation != nil) {
        [manager.operationQueue addOperation:operation];
    }
}

- (void)signInWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(MAResponseObject *))completion {
    [[DataManager sharedManager] showLoadingAnimation:YES andDone:NO];
    
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
//    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
//    
//    manager.securityPolicy.allowInvalidCertificates = YES;
    
    NSDictionary *parameters = @{
                                 @"grant_type": @"password",
                                 @"username": username,
                                 @"password": password
                                 };
    
    
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"Configurations" ofType:@"plist"];
    
    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configPath];
    
    NSString *hostInfo = [config objectForKey:@"host"];

    NSString *path = [hostInfo stringByAppendingString:BBApiSignIn];
    
    [self callWebserviceWithPath:path method:BBHTTPMethodPOST headerField:NULL parameters:parameters completion:completion];
    
//    NSError *error;
//    
//    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"Configurations" ofType:@"plist"];
//    NSDictionary *config = [NSDictionary dictionaryWithContentsOfFile:configPath];
//    
//    NSString *hostInfo = [config objectForKey:@"host"];
//    
//    NSMutableURLRequest *request = [manager.requestSerializer requestWithMethod:@"POST" URLString:[hostInfo stringByAppendingString:BBApiSignIn] parameters:parameters error:&error];
//    
//    [request setTimeoutInterval:BBNetWorkTimeOutInterval];
//    
//    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [operation setResponseSerializer:[AFJSONResponseSerializer alloc]];
//    
//    [operation setCompletionBlockWithSuccess: ^(AFHTTPRequestOperation *operation, id responseObject) {
//        MAResponseObject *responseObj = [MAResponseObject responseObjectWithRequestOperation:operation error:nil];
//        if (completion) {
//            completion(responseObj);
//        }
//    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
//        MAResponseObject *responseObj = [MAResponseObject responseObjectWithRequestOperation:operation error:error];
//        if (completion) {
//            completion(responseObj);
//        }
//    }];
//    
//    if (operation != nil) {
//        [manager.operationQueue addOperation:operation];
//    }
}

- (void)signOutWithUsername:(NSString *)username andPassword:(NSString *)password completion:(void (^)(MAResponseObject *))completion {
    [[DataManager sharedManager] showLoadingAnimation:YES andDone:NO];
    //
}

#pragma mark - List Job

- (void)getListJobsWithCompletion:(void (^)(MAResponseObject *))completion {
    //
}
@end
