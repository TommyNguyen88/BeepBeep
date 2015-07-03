//
//  RDSession.m
//  BeepBeep
//
//  Created by Nguyen Minh on 7/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "RDSession.h"

@implementation RDSession

+ (instancetype)sharedSession {
    static RDSession *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [RDSession new];
    });
    
    return _sharedInstance;
}

@end
