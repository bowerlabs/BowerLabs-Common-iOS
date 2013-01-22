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
    BLBlockOperation* operation = [[BLBlockOperation alloc] init];
    operation.blMainBlock = mainBlock;
    operation.blCompletionBlock = completionBlock;
    return operation;
}

- (void)main
{
    @autoreleasepool {
        if (self.blMainBlock) {
            self.blMainBlock();
        }
        
        if (self.blCompletionBlock) {
            self.blCompletionBlock(self);
        }
    }
}

@end
