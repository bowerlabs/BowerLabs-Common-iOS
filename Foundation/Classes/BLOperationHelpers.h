//
//  BLOperationHelpers.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#if !defined(__cplusplus)
#define BLExternC extern
#else
#define BLExternC extern "C"
#endif

typedef void(^BLMainThreadBlock)();
typedef void(^BLBackgroundBlock)();

BLExternC void performOnMainThread(BLMainThreadBlock block);
BLExternC void performOnMainThreadLater(BLMainThreadBlock block);
BLExternC void performOnMainThreadAfterDelay(NSTimeInterval delay, BLMainThreadBlock block);
BLExternC void performOnMainThreadAndWait(BLMainThreadBlock block);

BLExternC void performInBackground(BLBackgroundBlock);
BLExternC void performInBackgroundAfterDelay(NSTimeInterval delay, BLBackgroundBlock block);