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

@end
