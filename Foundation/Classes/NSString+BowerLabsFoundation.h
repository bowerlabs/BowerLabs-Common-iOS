//
//  NSString+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_OPTIONS(NSInteger, BLPhoneNumberFormatOptions) {
    BLPhoneNumberFormatOption10DigitNorthAmerican = 1 << 0,
    BLPhoneNumberFormatOption11DigitNorthAmerican = 1 << 1
};

extern BLPhoneNumberFormatOptions const BLPhoneNumberFormatOptionDefault;

@interface NSString (BowerLabsFoundation)

+ (NSString*)bl_stringWithUUID;
+ (NSString*)bl_stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding;

- (NSString*)bl_stringByCapitalizingFirstLetter;
- (NSString*)bl_stringByLowercasingFirstLetter;

- (NSString*)bl_trimWhitespace;
- (NSString*)bl_nilForEmptyString;

- (NSString*)bl_trimTrailingNewlines;

- (NSString*)bl_stringByRemovingCharactersInSet:(NSCharacterSet*)characterSet;

- (NSString*)bl_formatPhoneNumber;
- (NSString*)bl_formatPhoneNumberWithOptions:(BLPhoneNumberFormatOptions)options;

- (NSDate*)bl_dateValue;

- (NSNumber*)bl_numberValue;

@end
