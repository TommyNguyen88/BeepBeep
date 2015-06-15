//
//  FirstViewController.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/12/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "SuperViewController.h"
@class MainViewController;

@interface FirstViewController : SuperViewController

@property (strong, readwrite, nonatomic) MainViewController *mainViewController;
@property (strong, readwrite, nonatomic) UIViewController *contentViewController;

- (id)initWithContentViewController:(UIViewController *)contentViewController;
- (void)setContentViewController:(UIViewController *)contentViewController;

@end
