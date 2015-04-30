//
//  Class_Check_In_Model.h
//  Class_Check_In
//
//  Created by ITP Student on 4/29/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Class_Check_In_Model : NSObject
+ (instancetype) sharedModel;
- (NSUInteger)numberInRoster;
- (NSDictionary *)personAtRosterIndex: (NSUInteger) index;
- (void) insertPerson:(NSDictionary *) person atRosterIndex:(NSUInteger) index;
- (void) removePersonAtRosterIndex:(NSUInteger) index;
- (NSUInteger)numberOfDates;
- (NSDictionary *)dateAtIndex: (NSUInteger) index;
- (void) insertDate: (NSDictionary *) date atIndex: (NSUInteger) index;
- (void) removeDateAtIndex: (NSUInteger) index;

@end
