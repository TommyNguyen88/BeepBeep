//
//  MainViewController.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "BaseViewController.h"
#import "SignInViewController.h"
#import "MapViewController.h"
#import "FirstViewController.h"
#import "ListViewController.h"

@interface MainViewController : BaseViewController


@property (nonatomic, strong) SignInViewController *signInViewController;
@property (nonatomic, strong) MapViewController *mapViewController;
@property (nonatomic, strong) ListViewController *listViewController;
@property (nonatomic, strong) FirstViewController *firstViewController;

@end
