//
//  UIView+BowerLabsUIKit.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BowerLabsUIKit)

@property (nonatomic, strong) UIColor* bl_layerBorderColor;

- (void)setFrameWithCenter:(CGPoint)pt size:(CGSize)size;

- (CGPoint)convertUnitPoint:(CGPoint)unitPt;

- (void)applyRoundedTopCornersWithRadius:(CGFloat)radius;

- (CGPoint)centerBounds;

- (void)bottomAlignInSuperview;
- (void)bottomAlignInSuperviewWithHeight:(CGFloat)height;

- (void)topAlignInSuperview;
- (void)topAlignInSuperviewWithHeight:(CGFloat)height;

- (void)topRightAlignInSuperView;
- (void)topRightAlignInSuperViewWithSize:(CGSize)size;

- (void)topLeftAlignInSuperView;
- (void)topLeftAlignInSuperViewWithSize:(CGSize)size;

- (UIViewController*)firstAvailableViewController;

@end
