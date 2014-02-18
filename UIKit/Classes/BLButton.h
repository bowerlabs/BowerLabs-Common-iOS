//
//  BLButton.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BLButtonAlignment) {
    BLButtonAlignmentDefault,
    BLButtonAlignmentImageCenteredAboveTitle
};

typedef void(^BLButtonBlock)();

@interface BLButton : UIButton

@property (nonatomic, assign, readonly) BLButtonAlignment bl_buttonAlignment;
@property (nonatomic, assign, readonly) CGFloat bl_buttonAlignmentGuide;
@property (nonatomic, assign, readonly) CGFloat bl_buttonAlignmentMargin;
@property (nonatomic, assign, readonly) CGFloat bl_buttonAlignmentMaxImageDimension;

- (void)handleControlEvents:(UIControlEvents)controlEvents block:(BLButtonBlock)block;

- (void)bl_setButtonAlignment:(BLButtonAlignment)buttonAlignment guide:(CGFloat)guide maxImageDimension:(CGFloat)maxImageDimension margin:(CGFloat)margin;

@end
