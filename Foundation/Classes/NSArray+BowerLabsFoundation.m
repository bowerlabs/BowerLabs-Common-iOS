//
//  NSArray+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSArray+BowerLabsFoundation.h"

@implementation NSArray (BowerLabsFoundation)

- (id)bl_firstObject
{
    return (self.count > 0 ? [self objectAtIndex:0] : nil);
}

- (id)bl_lastObject
{
    return (self.count > 0 ? [self objectAtIndex:(self.count - 1)] : nil);
}

- (NSArray*)bl_headObjects
{
    return (self.count > 1 ? [self subarrayWithRange:NSMakeRange(0, self.count - 1)] : nil);
}

- (NSArray*)bl_tailObjects
{
    return (self.count > 1 ? [self subarrayWithRange:NSMakeRange(1, self.count - 1)] : nil);
}

- (NSArray*)bl_subarrayFromIndex:(NSUInteger)idx
{
    if (idx >= self.count) {
        return @[];
    }
    
    NSUInteger len = self.count - idx;
    return [self subarrayWithRange:NSMakeRange(idx, len)];
}

- (NSArray*)bl_arrayByMappingValuesUsing:(id (^)(id obj, NSUInteger idx, BOOL *stop))map
{
    __block NSMutableArray* mappedArray = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        obj = map(obj, idx, stop);
        if (nil == obj) {
            mappedArray = nil;
            *stop = YES;
        }
        else {
            [mappedArray addObject:obj];
        }
    }];
    
    return mappedArray;
}

- (NSArray*)bl_splitArrayAtIndex:(NSUInteger)index
{
    if (index == NSNotFound || index >= self.count) {
        return @[ self, @[] ];
    }
    
    NSUInteger len = (self.count - index);
    return @[
        [self subarrayWithRange:NSMakeRange(0, index)],
        [self subarrayWithRange:NSMakeRange(index, len)] ];
}

- (NSArray*)bl_groupedArrayUsingDescriptors:(NSArray*)sortDescriptors
{
    if (self.count == 0) {
        return [NSArray array];
    }
    else if(self.count == 1) {
        return [NSArray arrayWithObject:self];
    }
    
    id object1 = self.firstObject;
    NSMutableArray* group = [NSMutableArray arrayWithObject:object1];
    NSMutableArray* groups = [NSMutableArray arrayWithObject:group];
    for (id object2 in self.bl_tailObjects) {
        NSComparisonResult result = [self bl_compareObject:object1 toObject:object2 usingDescriptors:sortDescriptors];
        if (result != NSOrderedSame) {
            group = [NSMutableArray arrayWithObject:object2];
            [groups addObject:group];
        }
        else {
            [group addObject:object2];
        }
        
        object1 = object2;
    }
    
    return groups;
}

- (NSComparisonResult)bl_compareObject:(id)object1 toObject:(id)object2 usingDescriptors:(NSArray*)sortDescriptors
{
    for (NSSortDescriptor* sortDescriptor in sortDescriptors) {
        NSComparisonResult result = [sortDescriptor compareObject:object1 toObject:object2];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    return NSOrderedSame;
}

- (NSArray*)bl_arrayByShiftingLeft:(NSUInteger)shift
{
    if (self.count == 0) {
        return [NSArray array];
    }
    
    shift = shift % self.count;
    if (shift == 0) {
        return [NSArray arrayWithArray:self];
    }
    
    NSArray* array1 = [self subarrayWithRange:NSMakeRange(0, shift)];
    NSArray* array2 = [self subarrayWithRange:NSMakeRange(shift, self.count - shift)];
    
    return [array2 arrayByAddingObjectsFromArray:array1];
}

- (NSArray*)bl_arrayByRemovingObject:(id)object
{
    NSUInteger idx = [self indexOfObject:object];
    if (idx == NSNotFound) {
        return self;
    }
    
    return [self bl_arrayByRemovingObjectAtIndex:idx];
}

- (NSArray*)bl_arrayByInsertingObject:(id)object atIndex:(NSUInteger)index
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:(self.count + 1)];
    [array addObjectsFromArray:self];
    [array insertObject:object atIndex:index];
    return array;
}

- (NSArray*)bl_arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:self];
    [array replaceObjectAtIndex:index withObject:object];
    return array;
}

- (NSArray*)bl_arrayByRemovingObjectAtIndex:(NSUInteger)index
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:self];
    [array removeObjectAtIndex:index];
    return array;
}

- (NSArray*)bl_arrayBySwappingItemsAtIndex:(NSUInteger)indexA andIndex:(NSUInteger)indexB
{
    id objA = [self objectAtIndex:indexA];
    id objB = [self objectAtIndex:indexB];
    NSMutableArray* array = [NSMutableArray arrayWithArray:self];
    [array replaceObjectAtIndex:indexA withObject:objB];
    [array replaceObjectAtIndex:indexB withObject:objA];
    return array;
}

- (NSString*)bl_componentsJoinedByString:(NSString*)separator1
                      lastJoinedByString:(NSString*)separator2
{
    switch (self.count) {
        case 0:
            return @"";
        
        case 1:
            return self.firstObject;
            
        case 2:
            return [self componentsJoinedByString:separator2];
            
        default: {
            NSArray* a = @[ [[self bl_headObjects] componentsJoinedByString:separator1], self.lastObject ];
            return [a componentsJoinedByString:separator2];
        }
    }
}

- (id)bl_firstObjectMatchingFilter:(BOOL(^)(id obj, NSUInteger idx, BOOL *stop))filter
{
    if (!filter) {
        return nil;
    }
    
    __block id result = nil;
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (filter(obj, idx, stop)) {
            result = obj;
            *stop = YES;
        }
    }];
    
    return result;
}

- (NSArray*)bl_arrayByFilteringValuesUsing:(BOOL(^)(id obj, NSUInteger idx, BOOL *stop))filter
{
    __block NSMutableArray* result = [NSMutableArray array];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (filter(obj, idx, stop)) {
            [result addObject:obj];
        }
    }];
    
    return result;
}

@end
