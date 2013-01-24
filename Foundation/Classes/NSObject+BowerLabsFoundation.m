//
//  NSObject+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSObject+BowerLabsFoundation.h"

#import "BLKeyValueObserverForNSObjectOnly.h"

id nullForNil(id value)
{
    if (value == nil) {
        return [NSNull null];
    }
    
    return value;
}

@implementation NSObject (BowerLabsFoundation)

- (id)nilForNull
{
    return ([self isMemberOfClass:[NSNull class]] ? nil : self);
}

- (BLKeyValueObserver*)addObserverForKeyPath:(NSString*)keyPath
                                     options:(NSKeyValueObservingOptions)options
                                       block:(BLKeyValueObserverBlock)block
{
    return [[BLKeyValueObserver alloc] initWithObservedObject:self
                                                      keyPath:keyPath
                                                      options:options
                                                        block:block];
}

@end
