//
//  BLView.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-02-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLView.h"

@implementation BLView

- (id)initWithFrame:(CGRect)frame drawRect:(BLViewDrawRectBlock)drawRectBlock
{
    self = [super initWithFrame:frame];
    if (!self) { return nil; }
    
    self.drawRectBlock = drawRectBlock;
    
    return self;
}

- (void)layoutSubviews
{
    if (self.layoutSubviewsBlock) {
        self.layoutSubviewsBlock();
    }
    else {
        [super layoutSubviews];
    }
}

- (void)drawRect:(CGRect)rect
{
    if (self.drawRectBlock) {
        self.drawRectBlock(self, rect);
    }
}

@end
