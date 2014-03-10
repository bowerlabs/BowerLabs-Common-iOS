//
//  NSNotification+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSNotification+BowerLabsFoundation.h"

@implementation NSNotification (BowerLabsFoundation)

- (CGFloat)bl_keyboardHeight
{
    NSValue *value = [self.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    if (value) {
        CGRect frame = CGRectZero;
        [value getValue:&frame];
        return frame.size.height;
    } 
    else {
        return 0;
    }
}

- (CGFloat)bl_keyboardHeightForOrientation:(UIInterfaceOrientation)orientation
{
    NSValue *value = [self.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    if (value) {
        CGRect frame = CGRectZero;
        [value getValue:&frame];
        return (UIInterfaceOrientationIsPortrait(orientation) ?
                frame.size.height :
                frame.size.width);
    }
    else {
        return 0;
    }
}

- (NSTimeInterval)bl_keyboardAnimationDuration
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
