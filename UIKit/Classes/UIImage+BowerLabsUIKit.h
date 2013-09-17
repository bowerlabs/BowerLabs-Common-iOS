//
//  UIImage+BowerLabsUIKit.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BowerLabsUIKit)

+ (UIImage*)imageFromColor:(UIColor *)color;

+ (UIImage*)resizableImageNamed:(NSString*)imageName withCapInsets:(UIEdgeInsets)insets;

- (UIImage*)squareImageWithSides:(CGFloat)sides;

- (UIImage*)scaleToSize:(CGSize)targetSize;

- (UIImage*)scaleToMaxSide:(CGFloat)side;

- (UIImage *)fixOrientation;

@end
