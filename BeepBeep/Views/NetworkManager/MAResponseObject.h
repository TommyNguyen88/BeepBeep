//
//  MAResponseObject.h
//  BeepBeep
//
//  Created by Nguyen Minh on 7/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "JSONModel.h"

@interface MAResponseObject : JSONModel

@property (nonatomic, strong) NSString<Optional> *access_token;
@property (nonatomic, strong) NSString<Optional> *token_type;
@property (nonatomic) id<Optional> expires_in;
@property (nonatomic, strong) NSString<Optional> *error;
@property (nonatomic, strong) NSString<Optional> *error_description;

+ (MAResponseObject *)responseObjectWithRequestOperation:(AFHTTPRequestOperation *)operation
                                                   error:(NSError *)error;

@end
