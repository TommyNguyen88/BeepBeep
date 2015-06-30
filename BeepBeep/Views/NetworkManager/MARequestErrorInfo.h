//
//  MARequestErrorInfo.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/23/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MARequestErrorInfo : NSObject

@property (nonatomic, assign) NSInteger code;
@property (nonatomic, retain) NSString* descriptionErr;

- (id)initWithCode:(NSInteger)errCode description:(NSString *)errDescription;
@end
