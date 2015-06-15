//
//  RegisterViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/3/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "RegisterViewController.h"
//#import "UIButton+Extension.h"
//#import "UILabel+Extensions.h"

#define DistanceGoDown    10.0
#define DistanceGoDown2   30.0

@interface RegisterViewController () <UIAlertViewDelegate, UITextFieldDelegate>

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.txtFirstName.delegate = self;
    self.txtLastname.delegate = self;
    self.txtPhoneNumber.delegate = self;
    self.txtPhoneNumber.keyboardType = UIKeyboardTypePhonePad;
    self.txtEmailAddress.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self showOrHideItemsInView:NO];
    
    [self.lbAlertRegiater setHidden:YES];
    [self.lbAlertContact setHidden:YES];
    
    [self.lbWelcome setHidden:YES];
    [self.lbRegistrationSuccessful setHidden:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.view.window];
}

#pragma mark - General Methods
- (IBAction)pressBtnCancel:(id)sender {
    self.txtFirstName.text = TEXTNULL;
    self.txtLastname.text = TEXTNULL;
    self.txtPhoneNumber.text = TEXTNULL;
    self.txtEmailAddress.text = TEXTNULL;
    
    [self hideKeyboard];
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)pressBtnRegister:(id)sender {
    if ([self.txtFirstName.text isEqualToString:TEXTNULL]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:BBALERTConfirmation
                                                        message:@"First name can not be blank."
                                                       delegate:self
                                              cancelButtonTitle:BBALERTOKButton
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if ([self.txtPhoneNumber.text isEqualToString:TEXTNULL]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:BBALERTConfirmation
                                                        message:@"Phone number can not be blank."
                                                       delegate:self
                                              cancelButtonTitle:BBALERTOKButton
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if ([self.txtEmailAddress.text isEqualToString:TEXTNULL]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:BBALERTConfirmation
                                                        message:@"Email address can not be blank."
                                                       delegate:self
                                              cancelButtonTitle:BBALERTOKButton
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    if (![self.txtEmailAddress regularExpressionForEmail:self.txtEmailAddress.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:BBALERTConfirmation
                                                        message:BBALERTEMAILINVALID
                                                       delegate:self
                                              cancelButtonTitle:BBALERTOKButton
                                              otherButtonTitles:nil];
        alert.tag = 1;
        [alert show];
        return;
    }
    
    [self actionWhenRegisterSuccessful];
}

- (void)actionWhenRegisterFailed {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.lbAlertRegiater.hidden = NO;
    self.lbAlertContact.hidden = NO;
    
    [self setOriginYToButtonAndTextField:DistanceGoDown];
    
    [UIView commitAnimations];
}

- (void)actionWhenRegisterSuccessful {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    self.lbWelcome.hidden = NO;
    self.lbRegistrationSuccessful.hidden = NO;
    
    [self showOrHideItemsInView:YES];
    
    [self.imgLogoBeepBeep setFrame:CGRectMake(self.imgLogoBeepBeep.frame.origin.x, DEVICE_HEIGHT / 2 - 90, self.imgLogoBeepBeep.frame.size.width, self.imgLogoBeepBeep.frame.size.height)];
    
//    [self.lbWelcome setFrameXY:(DEVICE_WIDTH / 2) and:(DEVICE_HEIGHT / 2 - 10)];
//    [self.lbRegistrationSuccessful setFrameXY:(DEVICE_WIDTH / 2) and:(DEVICE_HEIGHT / 2 + 15)];
    
    [UIView commitAnimations];
    
    [self performSelector:@selector(pushViewWhenRegiaterSuccessful) withObject:nil afterDelay:1.5];
}

- (void)pushViewWhenRegiaterSuccessful {
    if (!self.firstViewController) {
        self.firstViewController = [[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    }
    
    [self.navigationController pushViewController:self.firstViewController animated:YES];
}

- (void)showOrHideItemsInView:(BOOL)isShow {
    self.txtFirstName.hidden = isShow;
    self.txtLastname.hidden = isShow;
    self.txtPhoneNumber.hidden = isShow;
    self.txtEmailAddress.hidden = isShow;
    
    self.lbRegister.hidden = isShow;
    
    self.btnCancel.hidden = isShow;
    self.btnRegister.hidden = isShow;
}

- (void)setOriginYToButtonAndTextField:(float)distance {
    [self.txtFirstName setFrameY:distance];
    [self.txtLastname setFrameY:distance];
    [self.txtPhoneNumber setFrameY:distance];
    [self.txtEmailAddress setFrameY:distance];
    
//    [self.btnCancel setFrameY:distance];
//    [self.btnRegister setFrameY:distance];
}

#pragma Mark - Alert Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    //
}

#pragma Mark - Keyboard show and hide
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y = -keyboardSize.height;
    
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
    [self.txtFirstName resignFirstResponder];
    [self.txtLastname resignFirstResponder];
    [self.txtPhoneNumber resignFirstResponder];
    [self.txtEmailAddress resignFirstResponder];
}

@end
