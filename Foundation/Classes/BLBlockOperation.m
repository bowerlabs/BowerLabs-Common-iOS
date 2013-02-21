//
//  BLBlockOperation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLBlockOperation.h"

@interface BLBlockOperation ()

@property (nonatomic, copy) BLBlockOperationMain blMainBlock;
@property (nonatomic, copy) BLBlockOperationCompletion blCompletionBlock;

@end

@implementation BLBlockOperation

+ (BLBlockOperation*)blockOperationWithMain:(BLBlockOperationMain)mainBlock
                                 completion:(BLBlockOperationCompletion)completionBlock
{
    return [self blockOperationWithStartup:nil main:mainBlock completion:completionBlock];
}

+ (BLBlockOperation*)blockOperationWithStartup:(BLBlockOperationStartup)startupBlock
                                          main:(BLBlockOperationMain)mainBlock
                                    completion:(BLBlockOperationCompletion)completionBlock
{
    BLBlockOperation* operation = [[BLBlockOperation alloc] init];
    operation.blMainBlock = mainBlock;
    operation.blCompletionBlock = completionBlock;
    
    if (startupBlock) {
        startupBlock(operation);
    }
    
    return operation;
}

- (void)main
{
    @autoreleasepool {
        @try {
            if (self.blMainBlock) {
                self.blMainBlock(self);
            }
        }
        @finally {
            if (self.blCompletionBlock) {
                self.blCompletionBlock(self);
            }
        }
    }
}

@end
