//
//  Class_Check_In_Model.m
//  Class_Check_In
//
//  Created by ITP Student on 4/29/15.
//  Copyright (c) 2015 Adrian Cagaanan. All rights reserved.
//

#import "Class_Check_In_Model.h"
@interface Class_Check_In_Model ()
//private properties
@property(strong, nonatomic)NSMutableArray *roster;
@property(strong, nonatomic)NSMutableArray *dates;
@property(strong, nonatomic)NSString *datesFilePath;
@property(strong, nonatomic)NSString *rosterFilePath;

@end
// plist Filename
NSString *const DatesPlist = @"dates.plist";
NSString *const RosterPlist = @"roster.plist";

@implementation Class_Check_In_Model
+(instancetype) sharedModel {
    static Class_Check_In_Model *_sharedModel = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // thread safe
        _sharedModel = [[self alloc] init];
        
    });
    
    return _sharedModel;
}

- (instancetype)init
{
    self = [super init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    _datesFilePath = [documentsDirectory stringByAppendingString:DatesPlist];
    _rosterFilePath = [documentsDirectory stringByAppendingString:RosterPlist];
    
    _dates = [NSMutableArray arrayWithContentsOfFile:_datesFilePath];
    _roster = [NSMutableArray arrayWithContentsOfFile:_rosterFilePath];
    
    if(!_dates){ // no file
        _datesFilePath = [[NSBundle mainBundle] pathForResource:@"dates" ofType:@"plist"];
        _dates = [NSMutableArray arrayWithContentsOfFile:_datesFilePath];
        
    }
    
    if(!_roster){ // no file
        _rosterFilePath = [[NSBundle mainBundle] pathForResource:@"roster" ofType:@"plist"];
        _roster = [NSMutableArray arrayWithContentsOfFile:_rosterFilePath];
    }
    
    return self;
}
- (void) save{
    
    
    [self.dates writeToFile:self.datesFilePath atomically:YES];
    [self.roster writeToFile:self.rosterFilePath atomically:YES];
}

- (NSUInteger)numberInRoster{
    return [self.roster count];
}

- (NSDictionary *)personAtRosterIndex: (NSUInteger) index{
    return [self.roster objectAtIndex:index];
}

- (void) insertPerson:(NSDictionary *) person atRosterIndex:(NSUInteger) index{
    NSUInteger numberInRoster = [self numberInRoster];
    if(index <= numberInRoster){
        [self.roster
         insertObject:person
         atIndex:index];
        [self save];
    }
}

- (void) removePersonAtRosterIndex:(NSUInteger) index{
    NSUInteger numberInRoster = [self numberInRoster];
    if(index < numberInRoster){
        [self.roster removeObjectAtIndex:index];
        [self save];
    }
}

- (NSUInteger)numberOfDates{
    return [self.dates count];
}
- (NSDictionary *)dateAtIndex: (NSUInteger) index{
    return [self.dates objectAtIndex:index];
}

- (void) insertDate: (NSDictionary *) date atIndex: (NSUInteger) index{
    NSUInteger numberOfDates = [self numberOfDates];
    if(index <= numberOfDates){
        [self.dates
         insertObject:date
         atIndex:index];
        [self save];
    }
}

- (void) removeDateAtIndex: (NSUInteger) index{
    NSUInteger numOfDates = [self numberOfDates];
    if(index < numOfDates){
        [self.dates removeObjectAtIndex:index];
        [self save];
    }
    
}
- (NSUInteger) dateIndexWhereIdEquals:(NSString *)personId{
    
    NSUInteger index = [self.dates indexOfObjectPassingTest:^BOOL(NSDictionary *item, NSUInteger idx, BOOL *stop){
        BOOL found =[[item objectForKey:@"id"] isEqualToString:personId];
        return found;
    }];
    return index;
}

@end
