//
//  BLBlockOperation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^BLBlockOperationStartup)(NSOperation* operation);
typedef void(^BLBlockOperationMain)(NSOperation* operation);
typedef void(^BLBlockOperationCompletion)(NSOperation* operation);

@interface BLBlockOperation : NSOperation

+ (BLBlockOperation*)blockOperationWithMain:(BLBlockOperationMain)mainBlock
                                 completion:(BLBlockOperationCompletion)completionBlock;

+ (BLBlockOperation*)blockOperationWithStartup:(BLBlockOperationStartup)startupBlock
                                          main:(BLBlockOperationMain)mainBlock
                                    completion:(BLBlockOperationCompletion)completionBlock;

@end
