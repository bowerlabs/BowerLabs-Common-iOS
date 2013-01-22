//
//  NSOperationQueue+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BLBlockOperation.h"

typedef void(^BLBlockOperationStartup)(NSOperation* operation);

@interface NSOperationQueue (BowerLabsFoundation)

+ (NSOperationQueue*)backgroundQueue;

- (void)addOperationWithStartup:(BLBlockOperationStartup)startupBlock
                           main:(BLBlockOperationMain)mainBlock
                     completion:(BLBlockOperationCompletion)completionBlock;

@end
