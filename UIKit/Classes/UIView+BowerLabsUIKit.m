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

- (void)setFrameWithCenter:(CGPoint)pt size:(CGSize)size
{
    self.frame = CGRectMake(pt.x - (size.width / 2),
                            pt.y - (size.height / 2),
                            size.width,
                            size.height);   
}

- (CGPoint)convertUnitPoint:(CGPoint)unitPt
{
    return CGPointMake(unitPt.x * self.bounds.size.width, unitPt.y * self.bounds.size.height);
}

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
    [self bottomAlignInSuperviewWithHeight:self.bounds.size.height];
}

- (void)bottomAlignInSuperviewWithHeight:(CGFloat)height
{
    CGFloat y = self.superview.bounds.size.height - height;
    CGFloat width = self.superview.bounds.size.width;
    self.frame = CGRectMake(0, y, width, height);
}

- (void)topAlignInSuperview
{
    [self topAlignInSuperviewWithHeight:self.bounds.size.height];
}

- (void)topAlignInSuperviewWithHeight:(CGFloat)height
{
    CGFloat width = self.superview.bounds.size.width;
    self.frame = CGRectMake(0, 0, width, height);
}

- (void)topRightAlignInSuperView
{
    [self topRightAlignInSuperViewWithSize:self.bounds.size];
}

- (void)topRightAlignInSuperViewWithSize:(CGSize)size
{
    CGFloat x = self.superview.bounds.size.width - size.width;
    self.frame = CGRectMake(x, 0, size.width, size.height);
}

- (void)topLeftAlignInSuperView
{
    [self topLeftAlignInSuperViewWithSize:self.bounds.size];
}

- (void)topLeftAlignInSuperViewWithSize:(CGSize)size
{
    self.frame = CGRectMake(0, 0, size.width, size.height);
}

- (UIViewController *)firstAvailableViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder firstAvailableViewController];
    }
    
    return nil;
}

@end
