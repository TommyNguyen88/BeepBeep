//
//  AppDelegate.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) MainViewController *mainViewController;
@property (nonatomic, retain) UINavigationController *navigationController;

@end
