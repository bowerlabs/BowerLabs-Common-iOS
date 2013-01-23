//
//  NSDate+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (BowerLabsFoundation)

+ (NSDate*)dateWithRFC822:(NSString*)value;

+ (NSDate*)dateWithRFC3339:(NSString*)value;

+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day calendar:(NSCalendar*)calendar;

- (NSDate*)startOfDay;

- (BOOL)isBefore:(NSDate *)date;

- (BOOL)isAfter:(NSDate *)date;

@end
