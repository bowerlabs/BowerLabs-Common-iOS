//
//  NSArray+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BowerLabsFoundation)

- (id)bl_firstObject;

- (id)bl_lastObject;

- (NSArray*)bl_headObjects;

- (NSArray*)bl_tailObjects;

- (NSArray*)bl_subarrayFromIndex:(NSUInteger)idx;

- (NSArray*)bl_arrayByMappingValuesUsing:(id (^)(id obj, NSUInteger idx, BOOL *stop))map;

- (NSArray*)bl_splitArrayAtIndex:(NSUInteger)index;

- (NSArray*)bl_groupedArrayUsingDescriptors:(NSArray*)sortDescriptors;

- (NSArray*)bl_arrayByShiftingLeft:(NSUInteger)shift;

- (NSArray*)bl_arrayByRemovingObject:(id)object;

- (NSArray*)bl_arrayByInsertingObject:(id)object atIndex:(NSUInteger)index;

- (NSArray*)bl_arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object;

- (NSArray*)bl_arrayByRemovingObjectAtIndex:(NSUInteger)index;

- (NSArray*)bl_arrayBySwappingItemsAtIndex:(NSUInteger)indexA andIndex:(NSUInteger)indexB;

- (NSString*)bl_componentsJoinedByString:(NSString*)separator1
                      lastJoinedByString:(NSString*)separator2;

- (id)bl_firstObjectMatchingFilter:(BOOL(^)(id obj, NSUInteger idx, BOOL *stop))filter;

- (NSArray*)bl_arrayByFilteringValuesUsing:(BOOL(^)(id obj, NSUInteger idx, BOOL *stop))filter;

@end
