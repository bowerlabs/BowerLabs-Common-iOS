//
//  UIImage+BowerLabsUIKit.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BowerLabsUIKit)

+ (UIImage*)bl_imageFromColor:(UIColor *)color;

+ (UIImage*)bl_resizableImageNamed:(NSString*)imageName withCapInsets:(UIEdgeInsets)insets;

- (UIImage*)bl_squareImageWithSides:(CGFloat)sides;
- (UIImage*)bl_squareImageWithSides:(CGFloat)sides scale:(CGFloat)scale;

- (UIImage*)bl_scaleToSize:(CGSize)targetSize;
- (UIImage*)bl_scaleToSize:(CGSize)targetSize scale:(CGFloat)scale;

- (UIImage*)bl_scaleToMaxSide:(CGFloat)side;
- (UIImage*)bl_scaleToMaxSide:(CGFloat)side scale:(CGFloat)scale;

- (UIImage*)bl_fixOrientation;

- (UIImage*)bl_setRetinaScaleIfNeeded;

- (UIImage *)bl_rasterizedImageWithTintColor:(UIColor *)color;

@end
