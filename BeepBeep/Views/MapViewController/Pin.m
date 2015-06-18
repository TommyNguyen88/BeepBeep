//
//  Pin.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/16/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "Pin.h"

@implementation Pin

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate {
    self = [super init];
    
    if (self) {
        _coordinate = newCoordinate;
        _title = @"Hello";
        _subtitle = @"Are you still there?";
    }
    return self;
}

@end
