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

- (NSArray*)splitArrayAtIndex:(NSUInteger)index;

@end
