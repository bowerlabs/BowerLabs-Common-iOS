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
    bounds.size.height += 10;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(radius, radius)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    [self.layer addSublayer:maskLayer];
    self.layer.mask = maskLayer;
    
    self.contentMode = UIViewContentModeRedraw;
}

- (CGPoint)centerBounds
{
    return CGPointMake(floor(CGRectGetMidX(self.bounds)),
                       floor(CGRectGetMidY(self.bounds)));
}

- (void)bottomAlignInSuperview
{
    [self bottomAlighInSuperviewWithHeight:self.bounds.size.height];
}

- (void)bottomAlighInSuperviewWithHeight:(CGFloat)height
{
    CGFloat y = self.superview.bounds.size.height - height;
    CGFloat width = self.superview.bounds.size.width;
    self.frame = CGRectMake(0, y, width, height);
}

@end
