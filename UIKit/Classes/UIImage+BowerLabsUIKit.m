//
//  UIImage+BowerLabsUIKit.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "UIImage+BowerLabsUIKit.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}

@implementation UIImage (BowerLabsUIKit)

+ (UIImage*)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage*)resizableImageNamed:(NSString*)imageName withCapInsets:(UIEdgeInsets)insets
{
    UIImage* image = [UIImage imageNamed:imageName];
    return [image resizableImageWithCapInsets:insets];
}

- (UIImage*)squareImageWithSides:(CGFloat)sides
{
    return [self squareImageWithSides:sides scale:self.scale];
}

- (UIImage*)squareImageWithSides:(CGFloat)sides scale:(CGFloat)scale
{
    UIImage* sourceImage = self;
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    size_t sourceW = CGImageGetWidth(imageRef);
    size_t sourceH = CGImageGetHeight(imageRef);
    
    CGFloat targetSides = sides * scale;
    CGFloat targetScale = (targetSides / MIN(sourceW, sourceH));
    CGFloat targetW = (sourceW * targetScale);
    CGFloat targetH = (sourceH * targetScale);
    CGFloat targetX = -(targetW - sides) / 2.0;
    CGFloat targetY = -(targetH - sides) / 2.0;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, sides, sides, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    CGContextDrawImage(bitmap, CGRectMake(targetX, targetY, targetW, targetH), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref scale:scale orientation:sourceImage.imageOrientation];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
}

- (UIImage*)scaleToSize:(CGSize)targetSize
{
    return [self scaleToSize:targetSize scale:self.scale];
}

- (UIImage*)scaleToSize:(CGSize)targetSize scale:(CGFloat)scale
{
    UIImage* sourceImage = self;
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    
    CGFloat targetWidth = targetSize.width * scale;
    CGFloat targetHeight = targetSize.height * scale;
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, targetWidth, targetHeight, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetWidth, targetHeight), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref scale:scale orientation:sourceImage.imageOrientation];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
}

- (UIImage*)scaleToMaxSide:(CGFloat)side
{
    return [self scaleToMaxSide:side scale:self.scale];
}

- (UIImage*)scaleToMaxSide:(CGFloat)side scale:(CGFloat)scale
{
    UIImage* sourceImage = self;
    if (MAX(sourceImage.size.width, sourceImage.size.height) <= side) {
        return self;
    }
    
    CGImageRef imageRef = [sourceImage CGImage];
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    CGColorSpaceRef colorSpaceInfo = CGImageGetColorSpace(imageRef);
    size_t sourceW = CGImageGetWidth(imageRef);
    size_t sourceH = CGImageGetHeight(imageRef);
    
    CGFloat targetSide = side * scale;
    CGFloat targetScale = (targetSide / MAX(sourceW, sourceH));
    CGFloat targetW = (sourceW * targetScale);
    CGFloat targetH = (sourceH * targetScale);
    
    CGContextRef bitmap = CGBitmapContextCreate(NULL, targetW, targetH, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, bitmapInfo);
    CGContextDrawImage(bitmap, CGRectMake(0, 0, targetW, targetH), imageRef);
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage* newImage = [UIImage imageWithCGImage:ref scale:scale orientation:sourceImage.imageOrientation];
    
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return newImage;
}

- (UIImage *)fixOrientation
{
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
