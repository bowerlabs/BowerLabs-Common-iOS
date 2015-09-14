//
//  NSDate+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSDate+BowerLabsFoundation.h"

@implementation NSDate (BowerLabsFoundation)

+ (NSDate*)bl_dateWithRFCFormattedString:(NSString*)value
{
    return [NSDate bl_dateWithISO8601FormattedString:value];
}

+ (NSDate*)bl_dateWithISO8601FormattedString:(NSString*)value
{
    if (!value) {
        return nil;
    }
    
    NSDate* date = nil;
    if ((date = [self bl_dateWithISO8601FormattedStringA:value]) ||
        (date = [self bl_dateWithISO8601FormattedStringB:value]) ||
        (date = [self bl_dateWithISO8601FormattedStringC:value]))
    {
        return date;
    }
    
    NSLog(@"Failed to parse RFC formatted datetime: %@", value);
    return nil;
}

+ (NSDate*)bl_dateWithISO8601FormattedStringA:(NSString*)value
{
    // Create a shared formatter.
    static NSRegularExpression* regex = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"(\\d{4})-?(\\d{2})-?(\\d{2})T(\\d{2}):?(\\d{2}):?(\\d{2})Z" options:0 error:nil];
    });
    
    // Match the string.
    NSTextCheckingResult* result = [regex firstMatchInString:value options:0 range:NSMakeRange(0, value.length)];
    if (result) {
        NSDateComponents* components = [[NSDateComponents alloc] init];
        components.year =   [[value substringWithRange:[result rangeAtIndex:1]] integerValue];
        components.month =  [[value substringWithRange:[result rangeAtIndex:2]] integerValue];
        components.day =    [[value substringWithRange:[result rangeAtIndex:3]] integerValue];
        components.hour =   [[value substringWithRange:[result rangeAtIndex:4]] integerValue];
        components.minute = [[value substringWithRange:[result rangeAtIndex:5]] integerValue];
        components.second = [[value substringWithRange:[result rangeAtIndex:6]] integerValue];
        
        components.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        
        // Create a calendar to avoid using the currentCalendar on different threads.
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
        return [calendar dateFromComponents:components];
    }
    
    return nil;
}

+ (NSDate*)bl_dateWithISO8601FormattedStringB:(NSString*)value
{
    // The maximum number of fractional seconds digits is equal to the
    // maximum number of number of nanosecond digits.
    NSInteger const MAX_FRACTIONAL_SECOND_DIGITS = 9;
    
    // Create a shared formatter.
    static NSRegularExpression* regex = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        NSString* pattern = [NSString stringWithFormat:@"(\\d{4})-?(\\d{2})-?(\\d{2})T(\\d{2}):?(\\d{2}):?(\\d{2}).(\\d{1,%li})Z", (long)MAX_FRACTIONAL_SECOND_DIGITS];
        regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    });
    
    // Match the string.
    NSTextCheckingResult* result = [regex firstMatchInString:value options:0 range:NSMakeRange(0, value.length)];
    if (result) {
        NSDateComponents* components = [[NSDateComponents alloc] init];
        components.year =   [[value substringWithRange:[result rangeAtIndex:1]] integerValue];
        components.month =  [[value substringWithRange:[result rangeAtIndex:2]] integerValue];
        components.day =    [[value substringWithRange:[result rangeAtIndex:3]] integerValue];
        components.hour =   [[value substringWithRange:[result rangeAtIndex:4]] integerValue];
        components.minute = [[value substringWithRange:[result rangeAtIndex:5]] integerValue];
        components.second = [[value substringWithRange:[result rangeAtIndex:6]] integerValue];
        
        NSInteger factionalSeconds = [[value substringWithRange:[result rangeAtIndex:7]] integerValue];
        if (factionalSeconds > 0) {
            NSInteger length = log10f(factionalSeconds) + 1.0;
            NSAssert(length <= MAX_FRACTIONAL_SECOND_DIGITS, @"Maximum length of fractional seconds exceeded");
            NSInteger factor = powf(10, MAX_FRACTIONAL_SECOND_DIGITS - length);
            NSInteger nanoseconds = factionalSeconds * factor;
            
            components.nanosecond = nanoseconds;
        }
        
        components.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
        
        // Create a calendar to avoid using the currentCalendar on different threads.
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
        return [calendar dateFromComponents:components];
    }
    
    return nil;
}

+ (NSDate*)bl_dateWithISO8601FormattedStringC:(NSString*)value
{
    // Create a shared formatter.
    static NSRegularExpression* regex = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"(\\d{4})-?(\\d{2})-?(\\d{2})T(\\d{2}):?(\\d{2}):?(\\d{2})([\\+-])(\\d{2}):?(\\d{2})" options:0 error:nil];
    });
    
    // Match the string.
    NSTextCheckingResult* result = [regex firstMatchInString:value options:0 range:NSMakeRange(0, value.length)];
    if (result) {
        NSDateComponents* components = [[NSDateComponents alloc] init];
        components.year =   [[value substringWithRange:[result rangeAtIndex:1]] integerValue];
        components.month =  [[value substringWithRange:[result rangeAtIndex:2]] integerValue];
        components.day =    [[value substringWithRange:[result rangeAtIndex:3]] integerValue];
        components.hour =   [[value substringWithRange:[result rangeAtIndex:4]] integerValue];
        components.minute = [[value substringWithRange:[result rangeAtIndex:5]] integerValue];
        components.second = [[value substringWithRange:[result rangeAtIndex:6]] integerValue];
        
        NSInteger offsetSign = ([[value substringWithRange:[result rangeAtIndex:7]] isEqualToString:@"-"] ? -1 : 1);
        NSInteger offsetHoursComponent = [[value substringWithRange:[result rangeAtIndex:8]] integerValue];
        NSInteger offsetMinutesComponent = [[value substringWithRange:[result rangeAtIndex:9]] integerValue];
        NSInteger offsetSeconds = offsetSign * ((offsetHoursComponent * 60 * 60) + (offsetMinutesComponent * 60));
        components.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:offsetSeconds];
        
        // Create a calendar to avoid using the currentCalendar on different threads.
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
        return [calendar dateFromComponents:components];
    }
    
    return nil;
}

+ (NSDate*)bl_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day
{
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    return [self bl_dateWithYear:year month:month day:day calendar:calendar];
}

+ (NSDate*)bl_dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day calendar:(NSCalendar*)calendar
{
    NSDateComponents* components = [[NSDateComponents alloc]  init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    return [calendar dateFromComponents:components];
}

+ (NSDate*)bl_today
{
    return [[NSDate date] bl_startOfDay];
}

+ (NSDate*)bl_tomorrow
{
    NSDate* today = [NSDate bl_today];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    return [calendar dateByAddingComponents:comps toDate:today options:0];
}

+ (NSDate*)bl_yesterday
{
    NSDate* today = [NSDate bl_today];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    return [calendar dateByAddingComponents:comps toDate:today options:0];
}

- (NSString*)bl_stringWithISO8601Format
{
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    return [dateFormatter stringFromDate:self];
}

- (NSDate*)bl_startOfYear
{
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    NSUInteger unitFlags = (NSCalendarUnitYear | NSCalendarUnitTimeZone);
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return [calendar dateFromComponents:comps];
}

- (NSDate*)bl_startOfMonth
{
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    NSUInteger unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitTimeZone);
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return [calendar dateFromComponents:comps];
}

- (NSDate*)bl_startOfDay
{
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    NSUInteger unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitTimeZone);
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return [calendar dateFromComponents:comps];
}

- (NSDate*)bl_startOfHour
{
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    NSUInteger unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitTimeZone);
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return [calendar dateFromComponents:comps];
}

- (NSDate*)bl_startOfMinute
{
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    NSUInteger unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitTimeZone);
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return [calendar dateFromComponents:comps];
}

- (NSDate*)bl_startOfSecond
{
    // Create a calendar to avoid using the currentCalendar on different threads.
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:[NSCalendar currentCalendar].calendarIdentifier];
    NSUInteger unitFlags = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitTimeZone);
    NSDateComponents *comps = [calendar components:unitFlags fromDate:self];
    return [calendar dateFromComponents:comps];
}

- (BOOL)bl_isBefore:(NSDate *)date
{
    return self.timeIntervalSinceReferenceDate < date.timeIntervalSinceReferenceDate;
}

- (BOOL)bl_isAfter:(NSDate *)date
{
    return self.timeIntervalSinceReferenceDate > date.timeIntervalSinceReferenceDate;
}

- (BOOL)bl_isEqualOrBefore:(NSDate*)date
{
    return self.timeIntervalSinceReferenceDate <= date.timeIntervalSinceReferenceDate;
}

- (BOOL)bl_isEqualOrAfter:(NSDate*)date
{
    return self.timeIntervalSinceReferenceDate >= date.timeIntervalSinceReferenceDate;
}

@end
