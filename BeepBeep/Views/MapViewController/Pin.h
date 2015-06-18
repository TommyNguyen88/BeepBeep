//
//  Pin.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/16/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <Foundation/Foundation.h>
@import MapKit;

@interface Pin : NSObject

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end
