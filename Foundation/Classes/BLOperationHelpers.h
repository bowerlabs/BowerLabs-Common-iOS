//
//  BLOperationHelpers.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BLMainThreadBlock)();

void performOnMainThread(BLMainThreadBlock block);
void performOnMainThreadAfterDelay(NSTimeInterval delay, BLMainThreadBlock block);
void performOnMainThreadAndWait(BLMainThreadBlock block);