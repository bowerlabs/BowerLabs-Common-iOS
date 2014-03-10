//
//  BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#ifndef BowerLabsFoundation_h
#define BowerLabsFoundation_h

#import "BLBlockOperation.h"
#import "BLDevice.h"
#import "BLError.h"
#import "BLKeyValueObserver.h"
#import "BLLocalization.h"
#import "BLOperationHelpers.h"
#import "NSArray+BowerLabsFoundation.h"
#import "NSData+BowerLabsFoundation.h"
#import "NSDate+BowerLabsFoundation.h"
#import "NSDictionary+BowerLabsFoundation.h"
#import "NSMutableArray+BowerLabsFoundation.h"
#import "NSMutableAttributedString+BowerLabsFoundation.h"
#import "NSNotification+BowerLabsFoundation.h"
#import "NSObject+BowerLabsFoundation.h"
#import "NSOperationQueue+BowerLabsFoundation.h"
#import "NSString+BowerLabsFoundation.h"
#import "NSTimer+BowerLabsFoundation.h"

NSString* bl_mangleKeyName(Class c, NSString* key);

/**
 Provides the ability to verify key paths at compile time.
 Source: https://gist.github.com/kyleve/8213806
 
 If "keyPath" does not exist, a compile-time error will be generated.
 
 Example:
 // Verifies "isFinished" exists on "operation".
 NSString *key = BLKeyPath(operation, isFinished);
 
 // Verifies "isFinished" exists on self.
 NSString *key = BLSelfKeyPath(isFinished);
 
 // Verifies "isFinished" exists on instances of NSOperation.
 NSString *key = BLTypedKeyPath(NSOperation, isFinished);
 */
#define BLKeyPath(object, keyPath) ({ if (NO) { (void)((object).keyPath); } @#keyPath; })

#define BLSelfKeyPath(keyPath) BLKeyPath(self, keyPath)
#define BLTypedKeyPath(ObjectClass, keyPath) BLKeyPath(((ObjectClass *)nil), keyPath)
#define BLProtocolKeyPath(Protocol, keyPath) BLKeyPath(((id <Protocol>)nil), keyPath)

#endif
