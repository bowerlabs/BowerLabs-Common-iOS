//
//  NSObject+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSObject+BowerLabsFoundation.h"

#import "BLKeyValueObserverForNSObjectOnly.h"
#import "BLOperationHelpers.h"

id nullForNil(id value)
{
    if (value == nil) {
        return [NSNull null];
    }
    
    return value;
}

@implementation NSObject (BowerLabsFoundation)

- (NSString*)bl_stringValue
{
    if ([self isKindOfClass:[NSString class]]) {
        return (NSString*) self;
    }
    else if ([self isKindOfClass:[NSNumber class]]) {
        return [(NSNumber*)self stringValue];
    }
    
    return nil;
}

- (id)nilForNull
{
    return ([self isMemberOfClass:[NSNull class]] ? nil : self);
}

#pragma mark - Observers

+ (NSMapTable*)sharedObserverMapTable
{
    static NSMapTable *sharedObserverMapTable = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        // Create the shared client.
        NSMapTableOptions keyOptions = (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
        NSMapTableOptions valueOptions = (NSPointerFunctionsStrongMemory | NSPointerFunctionsObjectPointerPersonality);
        sharedObserverMapTable = [NSMapTable mapTableWithKeyOptions:keyOptions valueOptions:valueOptions];
    });
    
    return sharedObserverMapTable;
}

- (id)addObserverForKeyPath:(NSString*)keyPath
                    options:(NSKeyValueObservingOptions)options
                      block:(BLKeyValueObserverBlock)block
{
    __block id observerRef = nil;
    [self addObserverForKeyPath:keyPath options:options startup:^(__weak id weakSelf, id ref) {
        observerRef = ref;
    } observer:block];
    
    return observerRef;
}

- (void)addObserverForKeyPath:(NSString*)keyPath
                      options:(NSKeyValueObservingOptions)options
                      startup:(BLKeyValueStartupBlock)startupBlock
                     observer:(BLKeyValueObserverBlock)observerBlock
{
    // Create the observer.
    BLKeyValueObserver* observerRef = [[BLKeyValueObserver alloc] init];
    
    // Call the startup block.
    if (startupBlock) {
        startupBlock(self, observerRef);
    }
    
    // Setup the observer.
    [observerRef setObservedObject:self
                           keyPath:keyPath
                           options:options
                             block:observerBlock];
    
    // Synchronize.
    NSMapTable* mapTable = [NSObject sharedObserverMapTable];
    @synchronized (mapTable) {
        @synchronized (observerRef) {
            if (!observerRef.isCancelled) {
                NSMutableArray* array = ([mapTable objectForKey:self] ?: [NSMutableArray array]);
                [array addObject:observerRef];
                [mapTable setObject:array forKey:self];
            }
        };
    }
}

- (void)removeObserver:(BLKeyValueObserver*)observerRef
{
    // Check for an observer ref.
    if (observerRef) {
        // Synchronize.
        NSMapTable* mapTable = [NSObject sharedObserverMapTable];
        @synchronized (mapTable) {
            @synchronized (observerRef) {
                NSMutableArray* array = [mapTable objectForKey:self];
                [array removeObject:observerRef];
                if (array.count == 0) {
                    [mapTable removeObjectForKey:self];
                }
                
                // Cancel the observer.
                [observerRef cancel];
            }
        };
    }
}

- (void)removeAllObservers
{
    // Synchronize.
    NSMapTable* mapTable = [NSObject sharedObserverMapTable];
    @synchronized (mapTable) {
        NSArray* array = [mapTable objectForKey:self];
        [mapTable removeObjectForKey:self];
        
        // Cancel the observers.
        for (BLKeyValueObserver* observerRef in array) {
            @synchronized (observerRef) {
                [observerRef cancel];
            }
        }
    };
}

@end
