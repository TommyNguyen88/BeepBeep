//
//  MAResponseObject.h
//  BeepBeep
//
//  Created by Nguyen Minh on 7/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "JSONModel.h"

@interface MAResponseObject : JSONModel

@property (nonatomic, assign) BOOL status;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSDictionary <Optional> *data;
@property (nonatomic, strong) NSString <Optional> *access_token;

+ (MAResponseObject *)responseObjectWithRequestOperation:(AFHTTPRequestOperation *)operation
                                                   error:(NSError *)error;

@end
