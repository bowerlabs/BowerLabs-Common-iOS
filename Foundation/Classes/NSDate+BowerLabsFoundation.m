//
//  NSDate+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSDate+BowerLabsFoundation.h"

@implementation NSDate (BowerLabsFoundation)

+ (NSDate*)dateWithRFC822:(NSString*)value
{
    // Create a shared formatter.
    static NSDateFormatter* formatter = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    });
    
    // It's common for some Rails servers to include a colon in the date/time string.
    // Correct the timezone so iOS can parse it using the built-in timezone formatter.
    if ([value characterAtIndex:22] == ':') {
        NSMutableString* tempStr = [NSMutableString stringWithString:value];
        [tempStr deleteCharactersInRange:NSMakeRange(22, 1)];
        value = tempStr;
    }
    
    // Convert to a date.
    return [formatter dateFromString:value];
}

+ (NSDate*)dateWithRFC3339:(NSString*)value
{
    // Create a shared formatter.
    static NSDateFormatter* formatter = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'";
    });
    
    // Convert to a date.
    return [formatter dateFromString:value];
}

+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    NSCalendar* calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [self dateWithYear:year month:month day:day calendar:calendar];
}

+ (NSDate*)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day calendar:(NSCalendar*)calendar
{
    NSDateComponents* components = [[NSDateComponents alloc]  init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    return [calendar dateFromComponents:components];
}

- (NSDate*)startOfDay
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    
    NSDateComponents *comps = [cal components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
                                     fromDate:self];
    return [cal dateFromComponents:comps];
}

- (BOOL)isBefore:(NSDate *)date
{
    return ([self compare:date] == NSOrderedAscending);
}

- (BOOL)isAfter:(NSDate *)date
{
    return ([self compare:date] == NSOrderedDescending);
}

@end
