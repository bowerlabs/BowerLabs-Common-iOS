//
//  NSMutableArray+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (BowerLabsFoundation)

- (void)bl_addObjectIfNotNil:(id)anObject;

- (id)bl_removeFirstObject;

@end
