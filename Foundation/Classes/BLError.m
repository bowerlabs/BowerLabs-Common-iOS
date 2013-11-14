//
//  BLError.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-10-10.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLError.h"

NSString* const BLErrorDomain = @"BLErrorDomain";
NSString* const BLErrorHttpStatusCodeKey = @"BLErrorHttpStatusCodeKey";

void BLSetErrorSafely(NSError** outError, NSError* error)
{
    if (outError) {
        *outError = error;
    }
}

void BLSetErrorSafelyBlock(NSError** outError, BLErrorFactoryBlock block)
{
    if (block) {
        BLSetErrorSafely(outError, block());
    }
}