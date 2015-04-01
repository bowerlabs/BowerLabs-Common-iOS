//
//  NSProgress+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Daniel Ivanisevic on 2015-03-31.
//  Copyright (c) 2015 Bower Labs Inc. All rights reserved.
//

#import "NSProgress+BowerLabsFoundation.h"

static NSString *BowerLabsFoundation_NSProgressResumableKey = @"BowerLabsFoundation_NSProgressResumableKey";
static NSString *BowerLabsFoundation_NSProgressResumingHandlerKey = @"BowerLabsFoundation_NSProgressResumingHandlerKey";

@implementation NSProgress (BowerLabsFoundation)

- (BOOL)bl_resumable
{
    return [[self.userInfo objectForKey:BowerLabsFoundation_NSProgressResumableKey] boolValue];
}

- (void)bl_setResumable:(BOOL)resumable
{
    [self setUserInfoObject:[NSNumber numberWithBool:resumable] forKey:BowerLabsFoundation_NSProgressResumableKey];
}

- (void)bl_setResumingHandler:(void (^)())handler
{
    [self setUserInfoObject:[handler copy] forKey:BowerLabsFoundation_NSProgressResumingHandlerKey];
}

- (void)bl_resume
{
    void (^handler)() = [self.userInfo objectForKey:BowerLabsFoundation_NSProgressResumingHandlerKey];

    if (handler != nil) {
        handler();
    }
}

@end
