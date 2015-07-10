//
//  MapViewController.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/11/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "SuperViewController.h"
#import <CoreLocation/CoreLocation.h>

@class MainViewController;

@interface MapViewController : SuperViewController
{
    GMSMapView *_googleMapView;
    GMSPlacesClient *_placesClient;
    GMSPlacePicker *_placePicker;
}

@property (nonatomic, strong) MainViewController *mainViewController;
@property (nonatomic, strong) CLLocationManager *locationManager;

@end
