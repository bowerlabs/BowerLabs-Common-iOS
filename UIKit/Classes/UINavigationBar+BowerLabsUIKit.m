//
//  UINavigationBar+BowerLabsUIKit.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "UINavigationBar+BowerLabsUIKit.h"

#import <QuartzCore/QuartzCore.h>

@implementation UINavigationBar (BowerLabsUIKit)

- (void)applyShadowWithColor:(UIColor*)color
                     opacity:(CGFloat)opacity
                      radius:(CGFloat)radius
{
    // Apply a shadow.
    [self.layer setShadowColor: [color CGColor]];
    [self.layer setShadowOpacity:opacity];
    [self.layer setShadowOffset: CGSizeMake(0.0f, 2.0f)];
    [self.layer setShadowRadius:radius];
    [self.layer setShouldRasterize:YES];
}

@end
