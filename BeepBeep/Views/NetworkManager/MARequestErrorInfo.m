//
//  MARequestErrorInfo.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/23/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "MARequestErrorInfo.h"

@implementation MARequestErrorInfo

- (id)initWithCode:(NSInteger)errCode description:(NSString *)errDescription {
    self = [super init];
    if (self) {
        self.code = errCode;
        self.descriptionErr = errDescription;
    }
    return self;
}

@end
