//
//  NSData+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-04-07.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSData+BowerLabsFoundation.h"

#import <CommonCrypto/CommonDigest.h>

@implementation NSData (BowerLabsFoundation)

- (NSString*)sha1
{
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(self.bytes, self.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}

@end
