//
//  Define.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#ifndef BeepBeep_Define_h
#define BeepBeep_Define_h

#define DEVICE_WIDTH            [[[[UIApplication sharedApplication] keyWindow] rootViewController].view convertRect:[[UIScreen mainScreen] bounds] fromView:nil].size.width
#define DEVICE_HEIGHT           [[[[UIApplication sharedApplication] keyWindow] rootViewController].view convertRect:[[UIScreen mainScreen] bounds] fromView:nil].size.height

#define Rgb2UIColor(r, g, b)    [UIColor colorWithRed: ((r) / 255.0) green: ((g) / 255.0) blue: ((b) / 255.0) alpha: 1.0]
#define BBColorToSubRowMenu     Rgb2UIColor(35.0, 40.0, 49.0)

// Google Map API
#define BBGoogleApiGetDistance                              @"https://maps.googleapis.com/maps/api/directions/json"
#define BBGoogleServerKey                                   @"AIzaSyDsYTYozs3462lr7YdrjXFdbPj5xZTys3I"
#define BBGoogleIOSKey                                      @"AIzaSyCqQ4JcgI0EqWcaHuUPOswCNyMe1piX7qg"

//URL which to call API
#define BBApiSignIn                                         @"/oauth/token"
#define BBApiGetListJob                                     @"/api/listJobs"
#define BBHTTPMethodPOST                                    @"POST"
#define BBNetWorkTimeOutInterval                            30

// KEYS
#define BBDataHasChanged                                    @"__BBDataHasChanged__"

#define TEXTNULL                                            @""
#define BBALERTOKButton                                     @"OK"
#define BBALERTCancelButton                                 @"Cancel"
#define BBALERTConfirmation                                 @"Confirmation"

#define BBALERTNULLTEXTFIELD                                @"Email and password can not be blank."
#define BBALERTTEXTINCORRECT                                @"Email or password is incorrect. Please try again."
#define BBALERTEMAILINVALID                                 @"Email address is invalid. Please try again."

#define BBNotificationToMenuItemBar                         @"_BBNotificationToMenuItemBar_"
#define BBNotificationShowMenu                              @"_BBNotificationShowMenu_"

#define BBNotificationShowMapView                           @"_BBNotificationShowMapView_"
#define BBNotificationShowListView                          @"_BBNotificationShowListView_"
#define BBNotificationShowTopRightMenuBar                   @"_BBNotificationShowTopRightMenuBar_"
#define BBNotificationHideTopRightMenuBar                   @"_BBNotificationHideTopRightMenuBar_"

#define SYSTEM_VERSION_EQUAL_TO(v)                          ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)                      ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)          ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                         ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)             ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
