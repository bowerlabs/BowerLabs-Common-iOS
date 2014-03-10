//
//  NSObject+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BLKeyValueObserverBlock.h"

extern id bl_nullForNil(id value);

@class BLKeyValueObserver;

@interface NSObject (BowerLabsFoundation)

- (id)bl_nilForNull;

- (id)bl_addObserverForKeyPath:(NSString*)keyPath
                       options:(NSKeyValueObservingOptions)options
                         block:(BLKeyValueObserverBlock)block __attribute__((deprecated));

- (void)bl_addObserverForKeyPath:(NSString*)keyPath
                         options:(NSKeyValueObservingOptions)options
                         startup:(BLKeyValueStartupBlock)startupBlock
                        observer:(BLKeyValueObserverBlock)observerBlock;

- (void)bl_removeObserver:(id)observerRef;

- (void)bl_removeAllObservers;

- (NSString*)bl_stringValue;

@end
