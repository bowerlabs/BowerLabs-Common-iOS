//
//  BLMarginLabel.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLMarginLabel.h"

@implementation BLMarginLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIEdgeInsets insets = {0, 0, 0, 0};
        self.margins = insets;
    }
    
    return self;
}

- (void)drawTextInRect:(CGRect)rect 
{
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.margins)];
}

@end
