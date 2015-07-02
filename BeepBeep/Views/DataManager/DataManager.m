//
//  DataManager.m
//  BeepBeep
//
//  Created by Nguyen Minh on 7/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

+ (instancetype)sharedManager {
    static DataManager *__sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __sharedManager = [DataManager new];
    });
    
    return __sharedManager;
}

#pragma mark - SAVE DATA

+ (BOOL)saveAllChanges {
    __block BOOL isSaved = YES;

    if ([NSManagedObjectContext defaultContext].hasChanges) {
        DLog(@"DataManager:saveAllChanges: hasChanges");
        [[NSManagedObjectContext defaultContext] saveToPersistentStoreWithCompletion: ^(BOOL success, NSError *error) {
            isSaved = success;
            [[NSNotificationCenter defaultCenter] postNotificationName:BBDataHasChanged object:nil];
            if (success) {
                DLog(@"DataManager:saveAllChanges: DONE - %i, %i", isSaved, success);
            }
            else {
                DLog(@"DataManager:saveAllChanges: NO CHANGES");
            }
        }];
    }
    else {
        DLog(@"DataManager:saveAllChanges: hasChanges=NO --> nothing saved");
    }
    
    return isSaved;
}

@end
