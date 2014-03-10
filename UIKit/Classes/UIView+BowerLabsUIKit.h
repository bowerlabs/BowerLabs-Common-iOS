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

- (void)bl_setFrameWithCenter:(CGPoint)pt size:(CGSize)size;

- (CGPoint)bl_convertUnitPoint:(CGPoint)unitPt;

- (void)bl_applyRoundedTopCornersWithRadius:(CGFloat)radius;

- (CGPoint)bl_centerBounds;

- (void)bl_bottomAlignInSuperview;
- (void)bl_bottomAlignInSuperviewWithHeight:(CGFloat)height;

- (void)bl_topAlignInSuperview;
- (void)bl_topAlignInSuperviewWithHeight:(CGFloat)height;

- (void)bl_topRightAlignInSuperView;
- (void)bl_topRightAlignInSuperViewWithSize:(CGSize)size;

- (void)bl_topLeftAlignInSuperView;
- (void)bl_topLeftAlignInSuperViewWithSize:(CGSize)size;

- (UIViewController*)bl_firstAvailableViewController;

#pragma mark - Positioning

@property (nonatomic, assign) CGFloat bl_minX;
@property (nonatomic, assign) CGFloat bl_maxX;

@property (nonatomic, assign) CGFloat bl_minY;
@property (nonatomic, assign) CGFloat bl_maxY;

@property (nonatomic, assign) CGFloat bl_centerX;
@property (nonatomic, assign) CGFloat bl_centerY;

@property (nonatomic, assign) CGFloat bl_width;
@property (nonatomic, assign) CGFloat bl_height;

@property (nonatomic, assign) CGPoint bl_origin;
@property (nonatomic, assign) CGSize bl_size;

@property (nonatomic, strong, readonly) UIView *bl_subviewWithMinX;
@property (nonatomic, strong, readonly) UIView *bl_subviewWithMaxX;
@property (nonatomic, strong, readonly) UIView *bl_subviewWithMinY;
@property (nonatomic, strong, readonly) UIView *bl_subviewWithMaxY;

-(void)bl_centerAlignInSuperview;

@end
