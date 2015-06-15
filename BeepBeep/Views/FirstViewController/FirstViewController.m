//
//  FirstViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/12/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@property (strong, readwrite, nonatomic) UIView *contentViewContainer;

@end

@implementation FirstViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _contentViewContainer = [[UIView alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:_contentViewContainer];
    _contentViewContainer.frame = self.view.bounds;
    _contentViewContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self addChildViewController:_contentViewController];
    _contentViewController.view.frame = self.view.bounds;
    [_contentViewContainer addSubview:_contentViewController.view];
    [_contentViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Public methods

- (id)initWithContentViewController:(UIViewController *)contentViewController {
    self = [self init];
    if (self) {
        _contentViewController = contentViewController;
    }
    return self;
}

- (void)setContentViewController:(UIViewController *)contentViewController {
    if (!_contentViewController) {
        _contentViewController = contentViewController;
    }
    
    [self hideViewController:_contentViewController];
    _contentViewController = contentViewController;
    
    [self addChildViewController:self.contentViewController];
    self.contentViewController.view.frame = self.view.bounds;
    [self.contentViewContainer addSubview:self.contentViewController.view];
    [self.contentViewController didMoveToParentViewController:self];
}

- (void)hideViewController:(UIViewController *)viewController {
    [viewController willMoveToParentViewController:nil];
    [viewController.view removeFromSuperview];
    [viewController removeFromParentViewController];
}

@end
