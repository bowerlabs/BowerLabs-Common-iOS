//
//  UIView+BowerLabsUIKit.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "UIView+BowerLabsUIKit.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIView (BowerLabsUIKit)

- (void)applyRoundedTopCornersWithRadius:(CGFloat)radius
{
    // Round corners of the navigation bar.
    CGRect bounds = self.layer.bounds;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    [self.layer addSublayer:maskLayer];
    self.layer.mask = maskLayer;
}

- (CGPoint)centerBounds
{
    return CGPointMake(floor(CGRectGetMidX(self.bounds)),
                       floor(CGRectGetMidY(self.bounds)));
}

@end
