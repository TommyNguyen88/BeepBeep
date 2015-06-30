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

- (void)signUpWithUsername:(NSString *)username andPassword:(NSString *)password {
    //
}

@end
