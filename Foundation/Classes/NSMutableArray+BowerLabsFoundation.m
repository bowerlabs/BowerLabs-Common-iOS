//
//  NSMutableArray+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSMutableArray+BowerLabsFoundation.h"

@implementation NSMutableArray (BowerLabsFoundation)

- (void)addObjectIfNotNil:(id)anObject
{
    if (anObject) {
        [self addObject:anObject];
    }
}

- (id)removeFirstObject
{
    if (self.count == 0) {
        return nil;
    }
    
    id obj = [self objectAtIndex:0];
    [self removeObjectAtIndex:0];
    return obj;
}

@end
