//
//  NSOperationQueue+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSOperationQueue+BowerLabsFoundation.h"

@implementation NSOperationQueue (BowerLabsFoundation)

+ (NSOperationQueue*)backgroundQueue
{
    static dispatch_once_t once;
    static NSOperationQueue* backgroundQueue;
    dispatch_once(&once, ^{
        backgroundQueue = [[NSOperationQueue alloc] init];
    });
    
    return backgroundQueue;
}


- (void)addOperationWithStartup:(BLBlockOperationStartup)startupBlock
                           main:(BLBlockOperationMain)mainBlock
                     completion:(BLBlockOperationCompletion)completionBlock
{
    BLBlockOperation* operation = [BLBlockOperation blockOperationWithMain:mainBlock
                                                                completion:completionBlock];
    if (startupBlock) {
        startupBlock(operation);
    }
    
    [self addOperation:operation];
}

@end
