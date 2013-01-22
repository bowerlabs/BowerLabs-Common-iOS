//
//  NSString+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSString+BowerLabsFoundation.h"

@implementation NSString (BowerLabsFoundation)

+ (NSString*)stringWithData:(NSData*)data encoding:(NSStringEncoding)encoding
{
    return [[NSString alloc] initWithData:data encoding:encoding];
}

+ (NSString*)stringWithUUID
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

- (NSString*)stringByCapitalizingFirstLetter
{
    if (self.length == 0) {
        return self;
    }
    
    return [self stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                         withString:[[self substringToIndex:1] capitalizedString]];
}

- (NSString*)trimWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)nilForEmptyString
{
    return (self.length > 0 ? self : nil);
}

@end
