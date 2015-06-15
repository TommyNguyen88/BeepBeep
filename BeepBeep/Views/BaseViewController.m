//
//  BaseViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "BaseViewController.h"
#import "MLKMenuPopover.h"

@interface BaseViewController () <MLKMenuPopoverDelegate>

@property (nonatomic, strong) MLKMenuPopover *menuPopover;
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.menuItems = [NSArray arrayWithObjects:@"Settings", @"About", nil];
    [self initialiZeMenuButtonInTopRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - General Installation
- (void)initialiZeMenuButtonInTopRight {
    UIButton *btnTopRight = [[UIButton alloc]initWithFrame:CGRectMake(DEVICE_WIDTH - 30, 10, 30, 30)];
    [btnTopRight setImage:[UIImage imageNamed:@"btnTopLeft"] forState:UIControlStateNormal];
    [btnTopRight setTitle:@"" forState:UIControlStateNormal];
    [btnTopRight addTarget:self action:@selector(actionShowMenuTopRight:) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:btnTopRight];
}

- (void)actionShowMenuTopRight:(id)sender {
    BOOL isShow = YES;
    CGRect menuPopoverRect = CGRectMake(DEVICE_WIDTH - 128, 30, 120, 60);
    
    self.menuPopover = [[MLKMenuPopover alloc] initWithFrame:menuPopoverRect menuItems:self.menuItems];
    self.menuPopover.menuPopoverDelegate = self;
    if (isShow) {
        isShow = NO;
        [self.menuPopover showInView:self.view];
    }
}

#pragma mark MLKMenuPopoverDelegate
- (void)menuPopover:(MLKMenuPopover *)menuPopover didSelectMenuItemAtIndex:(NSInteger)selectedIndex {
    [self.menuPopover dismissMenuPopover];
    //
}

@end
