//
//  SignInViewController.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomTextField.h"
#import "FirstViewController.h"
#import "ListViewController.h"
#import "MapViewController.h"

@class MainViewController;

@interface SignInViewController : BaseViewController

@property (strong, readwrite, nonatomic) MainViewController *mainViewController;
@property (weak, nonatomic) IBOutlet CustomTextField *txtEmail;
@property (weak, nonatomic) IBOutlet CustomTextField *txtPassword;

@property (nonatomic, strong) FirstViewController *firstViewController;
@property (nonatomic, strong) MapViewController *mapViewController;
@property (nonatomic, strong) ListViewController *listViewController;

@end
