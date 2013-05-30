//
//  UIApplication+BowerLabsUIKit.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-05-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (BowerLabsUIKit)

+ (BOOL)isPad;
+ (BOOL)isPhone;
+ (BOOL)isWidescreen;

@end
