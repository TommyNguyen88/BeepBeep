//
//  MAResponseObject.m
//  BeepBeep
//
//  Created by Nguyen Minh on 7/2/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import "MAResponseObject.h"

@implementation MAResponseObject

+ (MAResponseObject *)responseObjectWithRequestOperation:(AFHTTPRequestOperation *)operation
                                                   error:(NSError *)error {
    NSString *responseString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
    DLog(@"Server response string: %@", responseString);
    DLog(@"Server response status code %d %@", (int)operation.response.statusCode, error.localizedDescription);
    
    NSError *parserError = nil;
    MAResponseObject *obj = [[MAResponseObject alloc] initWithDictionary:operation.responseObject error:&parserError];
    return obj;
}

@end
