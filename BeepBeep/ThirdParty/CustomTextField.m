//
//  CustomTextField.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/3/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "CustomTextField.h"

@implementation CustomTextField

- (void)drawRect:(CGRect)rect {
    self.autocorrectionType = UITextAutocorrectionTypeNo;
    self.autocapitalizationType = UITextAutocapitalizationTypeNone;
    [self setValue:[UIColor whiteColor]
                 forKeyPath:@"_placeholderLabel.textColor"];
    self.borderStyle = UITextBorderStyleLine;
    self.background = [UIImage imageNamed:@"BGTextfield"];
    
    CALayer *layer = self.layer;
    layer.backgroundColor = [[UIColor whiteColor] CGColor];
    layer.cornerRadius = 15.0;
    layer.masksToBounds = YES;
//    layer.borderWidth = 1.0;
//    layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor];
    [layer setShadowColor:[[UIColor blackColor] CGColor]];
//    [layer setShadowOpacity:1];
    [layer setShadowOffset:CGSizeMake(0, 2.0)];
//    [layer setShadowRadius:5];
    [self setClipsToBounds:NO];
    [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 15, bounds.origin.y,
                      bounds.size.width  , bounds.size.height );
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (BOOL)regularExpressionForEmail:(NSString *)checkString {
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)setFrameY:(float)originY {
    [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y + originY , self.frame.size.width, self.frame.size.height)];
}

@end
