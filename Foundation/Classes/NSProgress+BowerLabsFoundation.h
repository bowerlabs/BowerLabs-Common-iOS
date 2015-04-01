//
//  NSProgress+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Daniel Ivanisevic on 2015-03-31.
//  Copyright (c) 2015 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSProgress (BowerLabsFoundation)

- (BOOL)bl_resumable;
- (void)bl_setResumable:(BOOL)resumable;

- (void)bl_setResumingHandler:(void (^)())handler;

- (void)bl_resume;

@end
