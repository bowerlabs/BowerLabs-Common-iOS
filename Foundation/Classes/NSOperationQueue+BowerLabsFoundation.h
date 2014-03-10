//
//  NSOperationQueue+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BLBlockOperation.h"

@interface NSOperationQueue (BowerLabsFoundation)

+ (NSOperationQueue*)bl_backgroundQueue;

- (void)bl_addOperationWithStartup:(BLBlockOperationStartup)startupBlock
                              main:(BLBlockOperationMain)mainBlock
                        completion:(BLBlockOperationCompletion)completionBlock;

@end
