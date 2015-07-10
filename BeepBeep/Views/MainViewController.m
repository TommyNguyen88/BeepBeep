//
//  MainViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma Mark - Public method
- (IBAction)pressButtonSignIn:(id)sender {
//    if (!_signInViewController) {
//        _signInViewController = [[SignInViewController alloc] initWithNibName:@"SignInViewController" bundle:nil];
//    }
//    
//    [self.navigationController pushViewController:_signInViewController animated:YES];
    
    if (!_mapViewController) {
        _mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:_mapViewController animated:YES];
}

@end
