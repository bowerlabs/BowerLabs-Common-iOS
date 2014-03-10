//
//  UIView+BowerLabsUIKit.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "UIView+BowerLabsUIKit.h"

#import "NSArray+BowerLabsFoundation.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (BowerLabsUIKit)

- (void)setBl_layerBorderColor:(UIColor *)bl_layerBorderColor
{
    [self willChangeValueForKey:@"bl_layerBorderColor"];
    self.layer.borderColor = [bl_layerBorderColor CGColor];
    [self didChangeValueForKey:@"bl_layerBorderColor"];
}

- (UIColor*)bl_layerBorderColor
{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)bl_setFrameWithCenter:(CGPoint)pt size:(CGSize)size
{
    self.frame = CGRectMake(pt.x - (size.width / 2),
                            pt.y - (size.height / 2),
                            size.width,
                            size.height);   
}

- (CGPoint)bl_convertUnitPoint:(CGPoint)unitPt
{
    return CGPointMake(unitPt.x * self.bounds.size.width, unitPt.y * self.bounds.size.height);
}

- (void)bl_applyRoundedTopCornersWithRadius:(CGFloat)radius
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

- (CGPoint)bl_centerBounds
{
    return CGPointMake(floor(CGRectGetMidX(self.bounds)),
                       floor(CGRectGetMidY(self.bounds)));
}

- (void)bl_bottomAlignInSuperview
{
    [self bl_bottomAlignInSuperviewWithHeight:self.bounds.size.height];
}

- (void)bl_bottomAlignInSuperviewWithHeight:(CGFloat)height
{
    CGFloat y = self.superview.bounds.size.height - height;
    CGFloat width = self.superview.bounds.size.width;
    self.frame = CGRectMake(0, y, width, height);
}

- (void)bl_topAlignInSuperview
{
    [self bl_topAlignInSuperviewWithHeight:self.bounds.size.height];
}

- (void)bl_topAlignInSuperviewWithHeight:(CGFloat)height
{
    CGFloat width = self.superview.bounds.size.width;
    self.frame = CGRectMake(0, 0, width, height);
}

- (void)bl_topRightAlignInSuperView
{
    [self bl_topRightAlignInSuperViewWithSize:self.bounds.size];
}

- (void)bl_topRightAlignInSuperViewWithSize:(CGSize)size
{
    CGFloat x = self.superview.bounds.size.width - size.width;
    self.frame = CGRectMake(x, 0, size.width, size.height);
}

- (void)bl_topLeftAlignInSuperView
{
    [self bl_topLeftAlignInSuperViewWithSize:self.bounds.size];
}

- (void)bl_topLeftAlignInSuperViewWithSize:(CGSize)size
{
    self.frame = CGRectMake(0, 0, size.width, size.height);
}

- (UIViewController *)bl_firstAvailableViewController
{
    id nextResponder = [self nextResponder];
    if ([nextResponder isKindOfClass:[UIViewController class]]) {
        return nextResponder;
    }
    else if ([nextResponder isKindOfClass:[UIView class]]) {
        return [nextResponder bl_firstAvailableViewController];
    }
    
    return nil;
}

#pragma mark - Positioning

@dynamic bl_maxX, bl_maxY, bl_width, bl_height, bl_origin, bl_size;

-(void)setBl_minX:(CGFloat)x
{
    CGRect r = self.frame;
    r.origin.x = x;
    self.frame = r;
}

-(void)setBl_maxX:(CGFloat)maxX
{
    CGRect frame = self.frame;
    frame.origin.x = maxX - frame.size.width;
    self.frame = frame;
}

-(void)setBl_minY:(CGFloat)y
{
    CGRect r = self.frame;
    r.origin.y = y;
    self.frame = r;
}

-(void)setBl_maxY:(CGFloat)maxY
{
    CGRect frame = self.frame;
    frame.origin.y = maxY - frame.size.height;
    self.frame = frame;
}

-(void)setBl_width:(CGFloat)width
{
    CGRect r = self.frame;
    r.size.width = width;
    self.frame = r;
}

-(void)setBl_height:(CGFloat)height
{
    CGRect r = self.frame;
    r.size.height = height;
    self.frame = r;
}

-(void)setBl_origin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

-(void)setBl_size:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

-(void)setBl_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

-(void)setBl_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

-(CGFloat)bl_minX
{
    return self.frame.origin.x;
}

-(CGFloat)bl_maxX
{
    return self.frame.origin.x + self.frame.size.width;
}

-(CGFloat)bl_minY
{
    return self.frame.origin.y;
}

-(CGFloat)bl_maxY
{
    return self.frame.origin.y + self.frame.size.height;
}

-(CGFloat)bl_centerX
{
    return self.center.x;
}

-(CGFloat)bl_centerY
{
    return self.center.y;
}

-(CGFloat)bl_width
{
    return self.frame.size.width;
}

-(CGFloat)bl_height
{
    return self.frame.size.height;
}

-(CGPoint)bl_origin
{
    return self.frame.origin;
}

-(CGSize)bl_size
{
    return self.frame.size;
}

-(UIView*)bl_subviewWithMinX
{
    if (self.subviews.count > 0) {
        UIView *outView = self.subviews.bl_firstObject;
        
        for(UIView *v in self.subviews.bl_tailObjects) {
            if(v.bl_minX < outView.bl_minX) {
                outView = v;
            }
        }
        
        return outView;
    }
    
    return nil;
}

-(UIView *)bl_subviewWithMaxX
{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews.bl_firstObject;
        
        for(UIView *v in self.subviews.bl_tailObjects) {
            if(v.bl_maxX > outView.bl_maxX) {
                outView = v;
            }
        }
        
        return outView;
    }
    
    return nil;
}

-(UIView*)bl_subviewWithMinY
{
    if (self.subviews.count > 0) {
        UIView *outView = self.subviews.bl_firstObject;
        
        for(UIView *v in self.subviews.bl_tailObjects) {
            if(v.bl_minY < outView.bl_minY) {
                outView = v;
            }
        }
        
        return outView;
    }
    
    return nil;
}

-(UIView *)bl_subviewWithMaxY
{
    if(self.subviews.count > 0){
        UIView *outView = self.subviews.bl_firstObject;
        
        for(UIView *v in self.subviews.bl_tailObjects) {
            if(v.bl_maxY > outView.bl_maxY) {
                outView = v;
            }
        }
        
        return outView;
    }
    
    return nil;
}

-(void)bl_centerAlignInSuperview
{
    if (self.superview){
        self.center = [self.superview bl_centerBounds];
    }
}

@end
