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

+ (NSString*)stringWithUUID;
+ (NSString*)stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding;

- (NSString*)stringByCapitalizingFirstLetter;
- (NSString*)stringByLowercasingFirstLetter;

- (NSString*)trimWhitespace;
- (NSString*)nilForEmptyString;

- (NSString*)bl_trimTrailingNewlines;

- (NSString*)stringByRemovingCharactersInSet:(NSCharacterSet*)characterSet;

- (NSString*)formatPhoneNumber;
- (NSString*)bl_formatPhoneNumberWithOptions:(BLPhoneNumberFormatOptions)options;

- (NSDate*)dateValue;

- (NSNumber*)bl_numberValue;

@end
