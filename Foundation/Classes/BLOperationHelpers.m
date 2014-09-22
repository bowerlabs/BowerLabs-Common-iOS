//
//  BLOperationHelpers.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLOperationHelpers.h"

void bl_performOnMainThread(BLMainThreadBlock block)
{
    if (!block) {
        return;
    }
    
    if ([NSThread isMainThread]) {
        block();
    }
    else {
        bl_performOnMainThreadLater(block);
    }
}

void bl_performOnMainThreadLater(BLMainThreadBlock block)
{
    if (!block) {
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), block);
}

void bl_performOnMainThreadAfterDelay(NSTimeInterval delay, BLMainThreadBlock block)
{
    if (!block) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

void bl_performOnMainThreadAndWait(BLMainThreadBlock block)
{
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

dispatch_queue_t bl_backgroundQueue()
{
    static dispatch_queue_t dispatchQueue;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        dispatchQueue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    });
    
    return dispatchQueue;
}

void bl_performInBackground(BLBackgroundBlock block)
{
    if (!block) {
        return;
    }
    
    dispatch_async(bl_backgroundQueue(), block);
}

void bl_performInBackgroundAfterDelay(NSTimeInterval delay, BLBackgroundBlock block)
{
    if (!block) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), bl_backgroundQueue(), block);
}