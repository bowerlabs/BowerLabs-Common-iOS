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

- (NSArray*)tailObjects;

- (NSArray*)arrayByMappingValuesUsing:(id (^)(id obj, NSUInteger idx, BOOL *stop))map;

- (NSArray*)splitArrayAtIndex:(NSUInteger)index;

- (NSArray*)groupedArrayUsingDescriptors:(NSArray*)sortDescriptors;

@end
