//
//  BLDevice.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 1/28/2014.
//  Copyright (c) 2014 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// Detect the larger iPhone.
inline static BOOL BLFoundationIsIPhone5()
{
    static dispatch_once_t once;
    static BOOL isIPhone5;
    dispatch_once(&once, ^{
        isIPhone5 = (([[UIScreen mainScreen] bounds].size.height-568)?NO:YES);
    });
    return isIPhone5;
}

// Detect iOS 7.
inline static BOOL BLFoundationIsIOS7OrLater()
{
    static dispatch_once_t once;
    static BOOL isIOS7OrLater;
    dispatch_once(&once, ^{
        isIOS7OrLater = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0);
    });
    return isIOS7OrLater;
}

// Detect iPad.
inline static BOOL BLFoundationIsIPad()
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
#else
    return NO;
#endif
}

// Detect iPhone
inline static BOOL BLFoundationIsIPhone()
{
#ifdef UI_USER_INTERFACE_IDIOM
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone);
#else
    return YES;
#endif
}