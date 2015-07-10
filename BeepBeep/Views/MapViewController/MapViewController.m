//
//  MapViewController.m
//  BeepBeep
//
//  Created by Nguyen Minh on 6/11/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "MapViewController.h"
#import "Pin.h"

#define Location1                   @"-33.044296, 149.678738"
#define Location2                   @"-33.586029, 150.004505"

@interface MapViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *allPins;
@property (nonatomic, strong) MKPolylineView *lineView;
@property (nonatomic, strong) MKPolyline *polyline;

@end

@implementation MapViewController

CLPlacemark *thePlacemark;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //    self.allPins = [NSMutableArray new];
    //    self.mapView.delegate = self;
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    if (IS_OS_8_OR_LATER) {
        [self.locationManager requestAlwaysAuthorization];
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    [self.locationManager startUpdatingLocation];
    //
    //    _mapView.showsUserLocation = YES;
    //    [_mapView setMapType:MKMapTypeStandard];
    //    [_mapView setZoomEnabled:YES];
    //    [_mapView setScrollEnabled:YES];
    
    _placesClient = [[GMSPlacesClient alloc] init];
    _googleMapView.settings.myLocationButton = YES;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-33.868
                                                            longitude:151.2086
                                                                 zoom:6.0];
    
    _googleMapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    _googleMapView.myLocationEnabled = YES;
    
    self.view = _googleMapView;
    
    [self getCurrentPlace];
    
    
    GMSUserAddedPlace *userAddedPlace = [[GMSUserAddedPlace alloc] init];
    userAddedPlace.name = @"Google Shoes!";
    userAddedPlace.address = @"48 Pirrama Road, Pyrmont, NSW 2009, Australia";
    userAddedPlace.coordinate = CLLocationCoordinate2DMake(-33.8669710, 151.1958750);
    userAddedPlace.phoneNumber = @"(02) 9374 4000";
    userAddedPlace.website = @"http://www.google.com.au/";
    userAddedPlace.types = @[@"shoe_store"];
    
    [_placesClient addPlace:userAddedPlace callback: ^(GMSPlace *place, NSError *error) {
        if (error != nil) {
            NSLog(@"User Added Place error %@", [error localizedDescription]);
            return;
        }
        
        NSLog(@"Added place with placeID %@", place.placeID);
        NSLog(@"Added Place name %@", place.name);
        NSLog(@"Added Place address %@", place.formattedAddress);
    }];
    
    [self addLocationToMapWithLatitude:-32.33 andLongitude:150.00];
    [self addLocationToMapWithLatitude:-34.33 andLongitude:152.00];
    
    [self drawLineOnGoogleMap];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Mark - Google Map Methods

- (void)getCurrentPlace {
    [_placesClient currentPlaceWithCallback: ^(GMSPlaceLikelihoodList *placeLikelihoodList, NSError *error) {
        if (error != nil) {
            DLog(@"Error -- %@", [error localizedDescription]);
            return;
        }
        
        if (placeLikelihoodList != nil) {
            for (GMSPlaceLikelihood *likelihood in placeLikelihoodList.likelihoods) {
                GMSPlace *place = likelihood.place;
                NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
                NSLog(@"Current Place address %@", place.formattedAddress);
                NSLog(@"Current Place attributions %@", place.attributions);
                NSLog(@"Current PlaceID %@", place.placeID);
            }
        }
    }];
}

- (void)addLocationToMapWithLatitude:(float)latitude
                        andLongitude:(float)longitude {
    // Creates market in the center of the map
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(latitude, longitude);
    marker.title = @"Sydney";
    marker.snippet = @"Australia";
    marker.appearAnimation = kGMSMarkerAnimationPop;
    marker.map = _googleMapView;
    //    marker.icon = [UIImage imageNamed:@"LogoBeepBeep"];
}

- (void)drawLineOnGoogleMap {
    GMSMutablePath *path = [GMSMutablePath path];
    [path addLatitude:-32.33 longitude:150.0]; // Sydney
    [path addLatitude:-34.33 longitude:152.0]; // Fiji
    
    CLLocationCoordinate2D coord1 = CLLocationCoordinate2DMake(-33.044296, 149.678738);
    CLLocationCoordinate2D coord2 = CLLocationCoordinate2DMake(-33.586029, 150.004505);
    
    double distance = [self getDistanceMetresBetweenLocationCoordinates:coord1 and:coord2];
    
    NSLog(@"distance -- %f", distance);
    
    [self getDistanceBetweenLocationCoordinatesFromServerGoogle:Location1 and:Location2];
    
    GMSPolyline *line = [GMSPolyline polylineWithPath:path];
    line.strokeColor = [UIColor redColor];
    line.strokeWidth = 5.0f;
    line.map = _googleMapView;
}

- (double)getDistanceMetresBetweenLocationCoordinates:(CLLocationCoordinate2D)coord1
                                                  and:(CLLocationCoordinate2D)coord2 {
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:coord1.latitude
                                                       longitude:coord1.longitude];
    
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:coord2.latitude
                                                       longitude:coord2.longitude];
    
    
    return [location1 distanceFromLocation:location2];
}

- (void)getDistanceBetweenLocationCoordinatesFromServerGoogle:(NSString *)position1 and:(NSString *)position2 {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSDictionary *dictParameters = @{ @"origin" : position1,
                                      @"destination" : position2,
                                      @"mode" : @"driving",
                                      @"key": BBGoogleServerKey };
    
    [manager GET:BBGoogleApiGetDistance parameters:dictParameters success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *arr = responseObject[@"routes"][0][@"legs"];
        NSMutableArray *loc = [[NSMutableArray alloc]init];
        
        NSString *dis, *dur;
        loc = [[arr valueForKey:@"distance"]valueForKey:@"text"];
        dis = loc[0];
        
        loc = [[arr valueForKey:@"duration"]valueForKey:@"text"];
        dur = loc[0];
    } failure: ^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end
