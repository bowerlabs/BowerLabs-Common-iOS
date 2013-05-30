//
//  UIApplication+BowerLabsUIKit.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-05-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "UIApplication+BowerLabsUIKit.h"

@implementation UIApplication (BowerLabsUIKit)

+ (BOOL)isPad
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

+ (BOOL)isPhone
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
#else
    return YES;
#endif
}

+ (BOOL)isWidescreen
{
    return [UIScreen mainScreen].bounds.size.height == 568.0;
}

@end
