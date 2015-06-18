//
//  NSString+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSString+BowerLabsFoundation.h"

#import "NSDate+BowerLabsFoundation.h"

BLPhoneNumberFormatOptions const BLPhoneNumberFormatOptionDefault =
(
 BLPhoneNumberFormatOption10DigitNorthAmerican |
 BLPhoneNumberFormatOption11DigitNorthAmerican
);

@implementation NSString (BowerLabsFoundation)

+ (NSString*)bl_stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding
{
    return [[NSString alloc] initWithData:data encoding:encoding];
}

+ (NSString*)bl_stringWithUUID
{
    // create a new UUID which you own
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    
    // create a new CFStringRef (toll-free bridged to NSString)
    // that you own
    NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    
    // release the UUID
    CFRelease(uuid);
    
    return [uuidString lowercaseString];
}

- (NSString*)bl_stringByCapitalizingFirstLetter
{
    if (self.length == 0) {
        return self;
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                         withString:[[self substringToIndex:1] capitalizedString]];
}

- (NSString*)bl_stringByLowercasingFirstLetter
{
    if (self.length == 0) {
        return self;
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                         withString:[[self substringToIndex:1] lowercaseString]];
}

- (NSString*)bl_trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)bl_trimTrailingNewlines
{
    NSCharacterSet* set = [NSCharacterSet newlineCharacterSet];
    NSUInteger trailingNewlineCount = 0;
    for (NSInteger index = self.length-1; index >= 0; index--) {
        if ([set characterIsMember:[self characterAtIndex:index]]) {
            trailingNewlineCount++;
        }
        else {
            break;
        }
    }
    
    if (trailingNewlineCount > 0) {
        return [self substringToIndex:(self.length - trailingNewlineCount)];
    }
    
    return self;
}

- (NSString*)bl_nilForEmptyString
{
    return (self.length > 0 ? self : nil);
}

- (NSString*)bl_stringByRemovingCharactersInSet:(NSCharacterSet*)characterSet
{
    NSMutableString* mutableString = [NSMutableString stringWithCapacity:self.length];
    for (NSUInteger index = 0; index < self.length; index++) {
        unichar c = [self characterAtIndex:index];
        if (isdigit(c)) {
            [mutableString appendFormat:@"%c", c];
        }
    }
    
    return mutableString;
}

- (NSString*)bl_formatPhoneNumber
{
    return [self bl_formatPhoneNumberWithOptions:BLPhoneNumberFormatOptionDefault];
}

- (NSString*)bl_formatPhoneNumberWithOptions:(BLPhoneNumberFormatOptions)options
{
    // Update the source string with the input.
    NSCharacterSet* nonDigitCharacterSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSString* digits = [self bl_stringByRemovingCharactersInSet:nonDigitCharacterSet];

    if (options & BLPhoneNumberFormatOption11DigitNorthAmerican) {
        // Check for a 1 prefix as the country code.
        BOOL hasCountryCode = [digits hasPrefix:@"1"];
        
        // Format the digits.
        NSString* formatted = digits;
        NSRange formatRange = (hasCountryCode ? NSMakeRange(5, 7) : NSMakeRange(4, 7));
        if (NSLocationInRange(digits.length, formatRange)) {
            // Strip the country code.
            if (hasCountryCode) {
                digits = [digits substringFromIndex:1];
            }
            
            if (4 <= digits.length && digits.length <= 6)
            {
                NSString* areaCode = [digits substringWithRange:NSMakeRange(0, 3)];
                NSString* prefix = [digits substringFromIndex:3];
                formatted = [NSString stringWithFormat:@"(%@) %@", areaCode, prefix];
            }
            else if (7 <= digits.length && digits.length <= 10)
            {
                NSString* areaCode = [digits substringWithRange:NSMakeRange(0, 3)];
                NSString* prefix = [digits substringWithRange:NSMakeRange(3, 3)];
                NSString* line = [digits substringFromIndex:6];
                formatted = [NSString stringWithFormat:@"(%@) %@-%@", areaCode, prefix, line];
            }
            
            // Add the country code.
            if (hasCountryCode) {
                formatted = [@"1 " stringByAppendingString:formatted];
            }
        }
        
        return formatted;
    }
    else if (options & BLPhoneNumberFormatOption10DigitNorthAmerican)
    {
        // Format the digits.
        NSString* formatted = digits;
        NSRange formatRange = NSMakeRange(4, 7);
        if (NSLocationInRange(digits.length, formatRange)) {
            if (4 <= digits.length && digits.length <= 6)
            {
                NSString* areaCode = [digits substringWithRange:NSMakeRange(0, 3)];
                NSString* prefix = [digits substringFromIndex:3];
                formatted = [NSString stringWithFormat:@"(%@) %@", areaCode, prefix];
            }
            else if (7 <= digits.length && digits.length <= 10)
            {
                NSString* areaCode = [digits substringWithRange:NSMakeRange(0, 3)];
                NSString* prefix = [digits substringWithRange:NSMakeRange(3, 3)];
                NSString* line = [digits substringFromIndex:6];
                formatted = [NSString stringWithFormat:@"(%@) %@-%@", areaCode, prefix, line];
            }
        }
        
        return formatted;
    }
    
    return digits;
}

- (NSDate*)bl_dateValue
{
    return [NSDate bl_dateWithISO8601FormattedString:self];
}

- (NSNumber*)bl_numberValue
{
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];
    return [f numberFromString:self];
}

@end
