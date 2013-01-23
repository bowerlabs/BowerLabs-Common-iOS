//
//  NSObject+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSObject+BowerLabsFoundation.h"

@implementation NSObject (BowerLabsFoundation)

- (id)nilForNull
{
    return ([self isMemberOfClass:[NSNull class]] ? nil : self);
}

- (void)afterDelay:(NSTimeInterval)delay perform:(void (^)(void))block
{
    [self afterDelay:delay queue:[NSOperationQueue mainQueue] perform:block];
}

- (void)afterDelay:(NSTimeInterval)delay queue:(NSOperationQueue*)queue perform:(void (^)(void))block
{
    NSOperation* operation = [NSBlockOperation blockOperationWithBlock:block];
    [queue performSelector:@selector(addOperation:)
                withObject:operation
                afterDelay:delay];
}

@end
