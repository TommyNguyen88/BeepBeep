//
//  MAPopUpViewController.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/11/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MAPopUpViewController : UIViewController

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *email;

- (void)showInView:(UIView *)aView animated:(BOOL)animated andPhoneNumber:(NSString *)phoneNumber andEmail:(NSString *)email;

@end
