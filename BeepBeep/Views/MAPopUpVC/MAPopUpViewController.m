//
//  MAPopUpViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/11/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "MAPopUpViewController.h"

@interface MAPopUpViewController ()

@end

@implementation MAPopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:.6];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionCall:(id)sender {
    [self removeAnimate];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@", self.phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else {
        UIAlertView *calert = [[UIAlertView alloc] initWithTitle:BBALERTConfirmation
                                                         message:@"Call facility is not available!!!"
                                                        delegate:nil
                                               cancelButtonTitle:BBALERTOKButton otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (IBAction)actionSendMessage:(id)sender {
    [self removeAnimate];
    NSURL *phoneUrl = [NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", self.phoneNumber]];
    
    if ([[UIApplication sharedApplication] canOpenURL:phoneUrl]) {
        [[UIApplication sharedApplication] openURL:phoneUrl];
    }
    else {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:BBALERTConfirmation
                                                        message:@"SMS facility is not available!!!"
                                                       delegate:nil
                                              cancelButtonTitle:BBALERTOKButton otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (IBAction)actionSendEmail:(id)sender {
    [self removeAnimate];
    NSURL *mailUrl = [NSURL URLWithString:[NSString stringWithFormat:@"mailto:%@", self.email]];
    
    if ([[UIApplication sharedApplication] canOpenURL:mailUrl]) {
        [[UIApplication sharedApplication] openURL:mailUrl];
    }
    else {
        UIAlertView *calert = [[UIAlertView alloc]initWithTitle:BBALERTConfirmation
                                                        message:@"Email facility is not available!!!"
                                                       delegate:nil
                                              cancelButtonTitle:BBALERTOKButton otherButtonTitles:nil, nil];
        [calert show];
    }
}

- (void)removeAnimate {
    [UIView animateWithDuration:.25 animations: ^{
        self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
        self.view.alpha = 0.0;
    } completion: ^(BOOL finished) {
        if (finished) {
            [self.view removeFromSuperview];
        }
    }];
}

- (void)showAnimate {
    self.view.transform = CGAffineTransformMakeScale(1.3, 1.3);
    self.view.alpha = 0;
    [UIView animateWithDuration:.25 animations: ^{
        self.view.alpha = 1;
        self.view.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (void)showInView:(UIView *)aView animated:(BOOL)animated andPhoneNumber:(NSString *)phoneNumber andEmail:(NSString *)email {
    self.phoneNumber = phoneNumber;
    self.email = email;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [aView addSubview:self.view];
        if (animated) {
            [self showAnimate];
        }
    });
}

@end
