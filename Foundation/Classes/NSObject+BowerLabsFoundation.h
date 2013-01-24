//
//  NSObject+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BLKeyValueObserverBlock.h"

extern id nullForNil(id value);

@class BLKeyValueObserver;

@interface NSObject (BowerLabsFoundation)

- (id)nilForNull;

- (BLKeyValueObserver*)addObserverForKeyPath:(NSString*)keyPath
                                     options:(NSKeyValueObservingOptions)options
                                       block:(BLKeyValueObserverBlock)block;

@end
