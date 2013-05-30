//
//  BLView.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-02-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLViewDrawRectBlock)(UIView* view, CGRect rect);
typedef void(^BLViewLayoutSubviewsBlock)();

@interface BLView : UIView

@property (nonatomic, copy) BLViewDrawRectBlock drawRectBlock;
@property (nonatomic, copy) BLViewLayoutSubviewsBlock layoutSubviewsBlock;

- (id)initWithFrame:(CGRect)frame drawRect:(BLViewDrawRectBlock)drawRectBlock;

@end
