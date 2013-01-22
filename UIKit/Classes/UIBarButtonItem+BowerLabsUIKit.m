//
//  UIBarButtonItem+BowerLabsUIKit.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "UIBarButtonItem+BowerLabsUIKit.h"

@implementation UIBarButtonItem (BowerLabsUIKit)

+ (UIBarButtonItem*)fixedSpace:(CGFloat)width
{
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace 
                                                                          target:nil 
                                                                          action:nil];
    item.width = width;
    return item;
}

+ (UIBarButtonItem*)flexibleSpace
{
    return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
}

@end
