//
//  BLButton.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLButton.h"

@interface BLButton ()

@property (nonatomic, copy) BLButtonBlock block;

@end

@implementation BLButton

- (void)handleControlEvents:(UIControlEvents)controlEvents block:(BLButtonBlock)block
{
    self.block = block;
    [self addTarget:self action:@selector(action:) forControlEvents:controlEvents];
}

- (void)action:(id)sender
{
    if (self.block) {
        self.block();
    }
}

@end
