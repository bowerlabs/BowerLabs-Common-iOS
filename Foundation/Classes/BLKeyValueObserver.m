//
//  BLKeyValueObserver.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-24.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLKeyValueObserver.h"

#import "BLKeyValueObserverBlock.h"

@interface BLKeyValueObserver ()

@property (nonatomic, copy) BLKeyValueObserverBlock block;
@property (nonatomic, strong) NSString* keyPath;
@property (nonatomic, weak) id observedObject;
@property (nonatomic, assign) BOOL isCancelled;

@end

@implementation BLKeyValueObserver

- (void)setObservedObject:(id)observedObject
                  keyPath:(NSString*)keyPath
                  options:(NSKeyValueObservingOptions)options
                    block:(BLKeyValueObserverBlock)block
{
    if (!self.isCancelled) {
        self.observedObject = observedObject;
        self.keyPath = keyPath;
        self.block = block;
        
        [observedObject addObserver:self forKeyPath:keyPath options:options context:NULL];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.block && !self.isCancelled) {
        id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
        id newValue = [object valueForKeyPath:keyPath];
        self.block(self.observedObject, oldValue, newValue);
    }
}

- (BOOL)isCancelled
{
    return _isCancelled;
}

- (void)cancel
{
    _isCancelled = YES;
    [self.observedObject removeObserver:self forKeyPath:self.keyPath];
    self.observedObject = nil;
    self.keyPath = nil;
    self.block = nil;
}

@end
