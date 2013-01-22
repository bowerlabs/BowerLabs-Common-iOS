//
//  BLOperationHelpers.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLOperationHelpers.h"

void performOnMainThread(BLMainThreadBlock block) {
    if (!block) {
        return;
    }
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

void performOnMainThreadAndWait(BLMainThreadBlock block) {
    if (!block) {
        return;
    }
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}