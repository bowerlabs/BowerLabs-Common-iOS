//
//  NSNotification+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSNotification (BowerLabsFoundation)

- (CGFloat)bl_keyboardHeight;
- (CGFloat)bl_keyboardHeightForOrientation:(UIInterfaceOrientation)orientation;
- (NSTimeInterval)bl_keyboardAnimationDuration;

@end
