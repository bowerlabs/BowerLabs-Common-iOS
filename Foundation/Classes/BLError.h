//
//  BLError.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-10-10.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

extern NSString* const BLErrorDomain;
extern NSString* const BLErrorHttpStatusCodeKey;

typedef NS_ENUM(NSInteger, BLErrorCode) {
    BLErrorCodeUnexpectedResponse = 1
};

extern void BLSetErrorSafely(NSError** outError, NSError* error);

typedef NSError*(^BLErrorFactoryBlock)();
extern void BLSetErrorSafelyBlock(NSError** outError, BLErrorFactoryBlock block);
