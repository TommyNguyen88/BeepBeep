//
//  ListViewController.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/12/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "SuperViewController.h"
#import <CCBottomRefreshControl/UIScrollView+BottomRefreshControl.h>

@class MainViewController;

@interface ListViewController : SuperViewController

@property (nonatomic, strong) MainViewController *mainViewController;
@end
