//
//  BLKeyValueObserverForNSObjectOnly.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-24.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLKeyValueObserver.h"
#import "BLKeyValueObserverBlock.h"

@interface BLKeyValueObserver (BLKeyValueObserverForNSObjectOnly)

- (void)setObservedObject:(id)observedObject
                  keyPath:(NSString*)keyPath
                  options:(NSKeyValueObservingOptions)options
                    block:(BLKeyValueObserverBlock)block;

- (void)cancel;

- (BOOL)isCancelled;

@end