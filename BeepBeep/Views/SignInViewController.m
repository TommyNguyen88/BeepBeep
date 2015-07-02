//
//  SignInViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "SignInViewController.h"
#import "MapViewController.h"
#import "ListViewController.h"
#import "NetworkManager.h"

#define userTest @"q"

@interface SignInViewController () <UIAlertViewDelegate, UITextFieldDelegate, NetworkManagerDelegate>

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.txtEmail.delegate = self;
    self.txtPassword.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionShowMapView) name:BBNotificationShowMapView object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionShowListView) name:BBNotificationShowListView object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Functions
- (IBAction)pressBtnSignIn:(id)sender {
    NSString *email = self.txtEmail.text;
    NSString *pass = self.txtPassword.text;
    
    if ([self.txtEmail.text isEqualToString:TEXTNULL] || [self.txtPassword.text isEqualToString:TEXTNULL]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:BBALERTConfirmation
                                                        message:BBALERTNULLTEXTFIELD
                                                       delegate:self
                                              cancelButtonTitle:BBALERTOKButton
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [[NetworkManager sharedManager] signInWithUsername:email andPassword:pass];
}

#pragma Mark - NetworkManager Delegate

- (void)smDidSignInWithUsername:(NSString *)username andPassword:(NSString *)password error:(MARequestErrorInfo *)error {
    if (error == nil) {
        //
    }
    else {
        [[[UIAlertView alloc] initWithTitle:@"Error" message:[error descriptionErr] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
}

#pragma Mark - Alert Delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1) {
        self.txtPassword.text = TEXTNULL;
    }
}

#pragma Mark - Keyboard show and hide
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 70 - keyboardSize.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = YES;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = 0;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.3];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
    // Remove TapGesture
    for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        if ([recognizer isKindOfClass:[UITapGestureRecognizer class]]) {
            [self.view removeGestureRecognizer:recognizer];
        }
    }
}

- (void)hideKeyboard {
    [self.txtEmail resignFirstResponder];
    [self.txtPassword resignFirstResponder];
}

#pragma Mark - actions to Menu

- (void)actionShowListView {
    if (!_listViewController) {
        _listViewController = [[ListViewController alloc] initWithNibName:@"ListViewController" bundle:nil];
        _listViewController.mainViewController = self.mainViewController;
    }
    [_firstViewController setContentViewController:_listViewController];
}

- (void)actionShowMapView {
    if (!_mapViewController) {
        _mapViewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
        _mapViewController.mainViewController = self.mainViewController;
    }
    [_firstViewController setContentViewController:_mapViewController];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
