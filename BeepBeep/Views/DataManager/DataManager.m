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

+ (SAMHUDView *)sharedHud {
    static dispatch_once_t onceToken;
    static SAMHUDView *_sharedHUD = nil;
    dispatch_once(&onceToken, ^{
        _sharedHUD = [[SAMHUDView alloc] initWithTitle:@"Loading..."];
        _sharedHUD.hudSize = CGSizeMake(200.0f, 120.0f);
        _sharedHUD.hidesVignette = YES;
    });
    
    return _sharedHUD;
}

+ (void)initData {
    //
}

- (void)showLoadingAnimation:(BOOL)on {
    if (on) {
        // TODO: Check double HUD showing!
        [[DataManager sharedHud] performSelector:@selector(resetTitle:) withObject:@"Loading..."];
        [[DataManager sharedHud] show];
    }
    else {
        [[DataManager sharedHud] completeWithTitle:@"Done"];
        [[DataManager sharedHud] performSelector:@selector(dismiss) withObject:nil afterDelay:0.2];
    }
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
