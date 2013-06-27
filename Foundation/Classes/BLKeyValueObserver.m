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

@end

@implementation BLKeyValueObserver

- (id)initWithObservedObject:(id)observedObject
                     keyPath:(NSString*)keyPath
                     options:(NSKeyValueObservingOptions)options
                       block:(BLKeyValueObserverBlock)block
{
    self = [super init];
    if (self) {
        self.observedObject = observedObject;
        self.keyPath = keyPath;
        self.block = block;
        
        [observedObject addObserver:self forKeyPath:keyPath options:options context:NULL];
    }
    
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (self.block) {
        id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
        id newValue = [change objectForKey:NSKeyValueChangeNewKey];
        self.block(self.observedObject, oldValue, newValue);
    }
}

- (void)cancel
{
    [self.observedObject removeObserver:self forKeyPath:self.keyPath];
    self.observedObject = nil;
    self.keyPath = nil;
    self.block = nil;
}

@end
