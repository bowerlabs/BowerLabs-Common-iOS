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

BLExternC void bl_performOnMainThread(BLMainThreadBlock block);
BLExternC void bl_performOnMainThreadLater(BLMainThreadBlock block);
BLExternC void bl_performOnMainThreadAfterDelay(NSTimeInterval delay, BLMainThreadBlock block);
BLExternC void bl_performOnMainThreadAndWait(BLMainThreadBlock block);

BLExternC void bl_performInBackground(BLBackgroundBlock);
BLExternC void bl_performInBackgroundAfterDelay(NSTimeInterval delay, BLBackgroundBlock block);