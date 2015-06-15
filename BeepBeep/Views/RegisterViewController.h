//
//  RegisterViewController.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/3/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomTextField.h"
#import "FirstViewController.h"

@interface RegisterViewController : BaseViewController

@property (strong, nonatomic) FirstViewController *firstViewController;
@property (weak, nonatomic) IBOutlet CustomTextField *txtFirstName;
@property (weak, nonatomic) IBOutlet CustomTextField *txtLastname;
@property (weak, nonatomic) IBOutlet CustomTextField *txtPhoneNumber;
@property (weak, nonatomic) IBOutlet CustomTextField *txtEmailAddress;
@property (weak, nonatomic) IBOutlet UILabel *lbRegister;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;
@property (weak, nonatomic) IBOutlet UILabel *lbAlertRegiater;
@property (weak, nonatomic) IBOutlet UILabel *lbAlertContact;
@property (weak, nonatomic) IBOutlet UILabel *lbWelcome;
@property (weak, nonatomic) IBOutlet UILabel *lbRegistrationSuccessful;
@property (weak, nonatomic) IBOutlet UIImageView *imgLogoBeepBeep;

@end
