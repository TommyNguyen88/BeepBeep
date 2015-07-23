//
//  DataManager.h
//  BeepBeep
//
//  Created by Nguyen Minh on 7/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAMHUDView.h"

@interface DataManager : NSObject

+ (instancetype)sharedManager;
+ (SAMHUDView *) sharedHud;
+ (void)initData;
+ (BOOL)saveAllChanges;

/**-----------------------------------------------------------------**/
- (void)showLoadingAnimation:(BOOL)on andDone:(BOOL)done;
- (NSArray *)getAllUsers;
@end
