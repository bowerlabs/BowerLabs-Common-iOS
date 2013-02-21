//
//  BLTextField.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-02-06.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTextField.h"

@implementation BLTextField

- (void) drawPlaceholderInRect:(CGRect)rect {
    if (self.placeholderColor) {
        [self.placeholderColor setFill];
        [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:UILineBreakModeClip alignment:self.textAlignment];
    }
    else {
        [super drawPlaceholderInRect:rect];
    }
}

@end
