//
//  BLTopRoundedNavigationBar.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-05-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTopRoundedNavigationBar.h"

#import <QuartzCore/QuartzCore.h>

CGFloat const BLTopRoundedNavigationBarRadius = 3.0;

@interface BLTopRoundedNavigationBar ()

@property (nonatomic, strong) CAShapeLayer* topRoundedMaskLayer;

@end

@implementation BLTopRoundedNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) { return nil; }
    
    self.topRoundedMaskLayer = [CAShapeLayer layer];
    [self updateTopRoundedMaskPath];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.layer.mask) {
        [self updateTopRoundedMaskPath];
    }
}

- (void)updateTopRoundedMaskPath
{
    
    // Round corners of the navigation bar.
    CGRect bounds = self.layer.bounds;
    bounds.size.height += 10;
    UIBezierPath* maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(BLTopRoundedNavigationBarRadius, BLTopRoundedNavigationBarRadius)];
    
    self.topRoundedMaskLayer.frame = bounds;
    self.topRoundedMaskLayer.path = maskPath.CGPath;
}

@end
