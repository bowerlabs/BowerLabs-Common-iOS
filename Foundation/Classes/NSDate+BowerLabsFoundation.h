//
//  NSDate+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BowerLabsFoundation)

+ (NSDate*)bl_dateWithRFCFormattedString:(NSString*)value;

+ (NSDate*)bl_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSDate*)bl_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day calendar:(NSCalendar*)calendar;

+ (NSDate*)bl_today;

+ (NSDate*)bl_tomorrow;

+ (NSDate*)bl_yesterday;

- (NSDate*)bl_startOfDay;

- (BOOL)bl_isBefore:(NSDate *)date;

- (BOOL)bl_isAfter:(NSDate *)date;

- (BOOL)bl_isEqualOrBefore:(NSDate*)date;

- (BOOL)bl_isEqualOrAfter:(NSDate*)date;

@end
