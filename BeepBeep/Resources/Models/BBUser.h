//
//  BBUser.h
//  BeepBeep
//
//  Created by Nguyen Minh on 6/25/15.
//  Copyright (c) 2015 Nguyen Minh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface BBUser : NSManagedObject

@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSString * token;

@end
