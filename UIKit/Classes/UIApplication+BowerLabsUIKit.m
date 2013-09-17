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

+ (BOOL)isOS7
{
    static dispatch_once_t once;
    static BOOL isIOS7;
    dispatch_once(&once, ^{
        isIOS7 = [[UIApplication sharedApplication] respondsToSelector:@selector(backgroundRefreshStatus)];
    });
    
    return isIOS7;
}

@end
