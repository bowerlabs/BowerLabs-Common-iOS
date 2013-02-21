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
    return (self.count ? [self objectAtIndex:0] : nil);
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

@end
