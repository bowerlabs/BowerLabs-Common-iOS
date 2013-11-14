//
//  NSArray+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (BowerLabsFoundation)

- (id)firstObject;

- (id)lastObject;

- (NSArray*)headObjects;

- (NSArray*)tailObjects;

- (NSArray*)arrayByMappingValuesUsing:(id (^)(id obj, NSUInteger idx, BOOL *stop))map;

- (NSArray*)splitArrayAtIndex:(NSUInteger)index;

- (NSArray*)groupedArrayUsingDescriptors:(NSArray*)sortDescriptors;

- (NSArray*)arrayByShiftingLeft:(NSUInteger)shift;

- (NSArray*)arrayByInsertingObject:(id)object atIndex:(NSUInteger)index;

- (NSArray*)arrayByReplacingObjectAtIndex:(NSUInteger)index withObject:(id)object;

- (NSArray*)arrayByRemovingObjectAtIndex:(NSUInteger)index;

- (NSArray*)arrayBySwappingItemsAtIndex:(NSUInteger)indexA andIndex:(NSUInteger)indexB;

- (NSString*)componentsJoinedByString:(NSString*)separator1
                   lastJoinedByString:(NSString*)separator2;

- (id)firstObjectMatchingFilter:(BOOL(^)(id obj, NSUInteger idx, BOOL *stop))filter;

- (NSArray*)arrayByFilteringValuesUsing:(BOOL(^)(id obj, NSUInteger idx, BOOL *stop))filter;

@end
