//
//  NSNotification+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSNotification+BowerLabsFoundation.h"

@implementation NSNotification (BowerLabsFoundation)

- (CGFloat)keyboardHeight 
{
    CGRect startFrame;
    NSValue *startFrameValue = [self.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    if (startFrameValue) {
        [startFrameValue getValue:&startFrame];
        return startFrame.size.height;
    } 
    else {
        return 0;
    }
}

- (NSTimeInterval)keyboardAnimationDuration
{
    NSValue* value = [self.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    if (value) {
        NSTimeInterval duration = 0;
        [value getValue:&duration];
        return duration;
    }
    else {
        return 0;
    }
}

@end
