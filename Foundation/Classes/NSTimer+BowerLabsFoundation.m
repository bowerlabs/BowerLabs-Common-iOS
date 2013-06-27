//
//  NSTimer+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-06-17.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSTimer+BowerLabsFoundation.h"

@implementation NSTimer (BowerLabsFoundation)

+ (id)scheduledTimerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    id ret = [self scheduledTimerWithTimeInterval:inTimeInterval target:self selector:@selector(BL_executeBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+ (id)timerWithTimeInterval:(NSTimeInterval)inTimeInterval block:(void (^)())inBlock repeats:(BOOL)inRepeats
{
    void (^block)() = [inBlock copy];
    id ret = [self timerWithTimeInterval:inTimeInterval target:self selector:@selector(BL_executeBlock:) userInfo:block repeats:inRepeats];
    return ret;
}

+ (void)BL_executeBlock:(NSTimer *)inTimer;
{
    if([inTimer userInfo])
    {
        void (^block)() = (void (^)())[inTimer userInfo];
        block();
    }
}

@end
