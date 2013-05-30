//
//  NSArray+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSArray+BowerLabsFoundation.h"

@implementation NSArray (BowerLabsFoundation)

- (id)firstObject
{
    return (self.count > 0 ? [self objectAtIndex:0] : nil);
}

- (id)lastObject
{
    return (self.count > 0 ? [self objectAtIndex:(self.count - 1)] : nil);
}

- (NSArray*)headObjects
{
    return (self.count > 1 ? [self subarrayWithRange:NSMakeRange(0, self.count - 1)] : nil);
}

- (NSArray*)tailObjects
{
    return (self.count > 1 ? [self subarrayWithRange:NSMakeRange(1, self.count - 1)] : nil);
}

- (NSArray*)arrayByMappingValuesUsing:(id (^)(id obj, NSUInteger idx, BOOL *stop))map
{
    NSMutableArray* mappedArray = [NSMutableArray arrayWithCapacity:self.count];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [mappedArray addObject:map(obj, idx, stop)];
    }];
    
    return mappedArray;
}

- (NSArray*)splitArrayAtIndex:(NSUInteger)index
{
    if (index == NSNotFound || index >= self.count) {
        return @[ self, @[] ];
    }
    
    NSUInteger len = (self.count - index);
    return @[
        [self subarrayWithRange:NSMakeRange(0, index)],
        [self subarrayWithRange:NSMakeRange(index, len)] ];
}

- (NSArray*)groupedArrayUsingDescriptors:(NSArray*)sortDescriptors
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
    for (id object2 in self.tailObjects) {
        NSComparisonResult result = [self compareObject:object1 toObject:object2 usingDescriptors:sortDescriptors];
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

- (NSComparisonResult)compareObject:(id)object1 toObject:(id)object2 usingDescriptors:(NSArray*)sortDescriptors
{
    for (NSSortDescriptor* sortDescriptor in sortDescriptors) {
        NSComparisonResult result = [sortDescriptor compareObject:object1 toObject:object2];
        if (result != NSOrderedSame) {
            return result;
        }
    }
    
    return NSOrderedSame;
}

- (NSArray*)arrayByShiftingLeft:(NSUInteger)shift
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

- (NSArray*)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:(self.count + 1)];
    [array addObjectsFromArray:self];
    [array insertObject:object atIndex:index];
    return array;
}

- (NSArray*)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:self];
    [array replaceObjectAtIndex:index withObject:object];
    return array;
}

- (NSArray*)arrayByRemovingObjectAtIndex:(NSUInteger)index
{
    NSMutableArray* array = [NSMutableArray arrayWithArray:self];
    [array removeObjectAtIndex:index];
    return array;
}

- (NSString*)componentsJoinedByString:(NSString*)separator1
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
            NSArray* a = @[ [[self headObjects] componentsJoinedByString:separator1], self.lastObject ];
            return [a componentsJoinedByString:separator2];
        }
    }
}

@end
