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
    // Observer must be created outside of the 'perform' block
    // so that the block is called on the same thread.
    id observerRef = [[BLKeyValueObserver alloc] initWithObservedObject:self
                                                                keyPath:keyPath
                                                                options:options
                                                                  block:block];
    
    // Synchronize.
    NSMapTable* mapTable = [NSObject sharedObserverMapTable];
    @synchronized (mapTable) {
        NSMutableArray* array = ([mapTable objectForKey:self] ?: [NSMutableArray array]);
        [array addObject:observerRef];
        [mapTable setObject:array forKey:self];
    };
    
    return observerRef;
}

- (void)removeObserver:(BLKeyValueObserver*)observerRef
{
    // Synchronize.
    NSMapTable* mapTable = [NSObject sharedObserverMapTable];
    @synchronized (mapTable) {
        NSMutableArray* array = [mapTable objectForKey:self];
        [array removeObject:observerRef];
        if (array.count == 0) {
            [mapTable removeObjectForKey:self];
        }
    };
    
    // Cancel the observer.
    [observerRef cancel];
}

- (void)removeAllObservers
{
    // Synchronize.
    __block NSArray* array = nil;
    NSMapTable* mapTable = [NSObject sharedObserverMapTable];
    @synchronized (mapTable) {
        array = [mapTable objectForKey:self];
        [mapTable removeObjectForKey:self];
    };
    
    // Cancel the observers.
    for (BLKeyValueObserver* observerRef in array) {
        [observerRef cancel];
    }
}

@end
