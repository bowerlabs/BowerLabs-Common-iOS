//
//  BLDevice.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 1/28/2014.
//  Copyright (c) 2014 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !defined(__cplusplus)
#define BLDeviceExternC extern
#else
#define BLDeviceExternC extern "C"
#endif

BLDeviceExternC BOOL BLFoundationIsIOS7OrLater();
BLDeviceExternC BOOL BLFoundationIsIOS8OrLater();
BLDeviceExternC BOOL BLFoundationIsIOS9OrLater();
BLDeviceExternC BOOL BLFoundationIsIPad();
BLDeviceExternC BOOL BLFoundationIsIPhone();