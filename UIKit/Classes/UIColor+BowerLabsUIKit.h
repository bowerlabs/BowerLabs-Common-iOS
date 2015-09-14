//
//  UIColor+BowerLabsUIKit.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BowerLabsUIKit)

+ (UIColor*)bl_colorWithIntegerRed:(NSInteger)r green:(NSInteger)g blue:(NSInteger)b alpha:(CGFloat)a;
+ (UIColor*)bl_colorWithHex:(NSInteger)hex alpha:(CGFloat)alpha;
+ (UIColor*)bl_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end
