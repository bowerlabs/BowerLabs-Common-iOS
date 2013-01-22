//
//  NSObject+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (BowerLabsFoundation)

- (id)nilForNull;
- (void)afterDelay:(NSTimeInterval)delay perform:(void (^)(void))block;

@end
