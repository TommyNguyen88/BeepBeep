//
//  RDSession.h
//  BeepBeep
//
//  Created by Nguyen Minh on 7/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "JSONModel.h"

@interface RDSession : JSONModel

@property (nonatomic, strong) NSNumber *authenticated;
@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *apiKey;
@property (strong, nonatomic) NSString *platform;
@property (strong, nonatomic) NSNumber *suggestAddItem;

+ (instancetype)sharedSession;
- (void)save;
- (void)restoreSessionIfNeeded;
- (void)printDescription;
- (void)clearSessionData;


@end
