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

static inline
CGRect BLCenterRect(CGRect rect, CGPoint pt)
{
    CGFloat halfWidth = (rect.size.width / 2);
    CGFloat halfHeight = (rect.size.height / 2);
    CGPoint origin = CGPointMake(pt.x - halfWidth, pt.y - halfHeight);
    return CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height);
}

@interface BLView : UIView

@property (nonatomic, copy) BLViewDrawRectBlock drawRectBlock;
@property (nonatomic, copy) BLViewLayoutSubviewsBlock layoutSubviewsBlock;

- (id)initWithFrame:(CGRect)frame drawRect:(BLViewDrawRectBlock)drawRectBlock;

@end
