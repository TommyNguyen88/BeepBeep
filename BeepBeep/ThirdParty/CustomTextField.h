//
//  CustomTextField.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/3/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextField : UITextField

- (BOOL)regularExpressionForEmail:(NSString *)checkString;
- (void)setFrameY:(float)originY;
@end
