//
//  BLDevice.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 1/28/2014.
//  Copyright (c) 2014 Bower Labs Inc. All rights reserved.
//

#import "BLDevice.h"

#import <UIKit/UIKit.h>

// Detect iOS 7.
BOOL BLFoundationIsIOS7OrLater()
{
    static dispatch_once_t once;
    static BOOL isIOS7OrLater;
    dispatch_once(&once, ^{
        isIOS7OrLater = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0);
    });
    return isIOS7OrLater;
}

// Detect iOS 8.
BOOL BLFoundationIsIOS8OrLater()
{
    static dispatch_once_t once;
    static BOOL isIOS8OrLater;
    dispatch_once(&once, ^{
        isIOS8OrLater = ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0);
    });
    return isIOS8OrLater;
}

// Detect iPad.
BOOL BLFoundationIsIPad()
{
    static dispatch_once_t once;
    static BOOL isIPad;
    dispatch_once(&once, ^{
        isIPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
    });
    return isIPad;
}

// Detect iPhone
BOOL BLFoundationIsIPhone()
{
    static dispatch_once_t once;
    static BOOL isIPhone;
    dispatch_once(&once, ^{
        isIPhone = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
    });
    return isIPhone;
}