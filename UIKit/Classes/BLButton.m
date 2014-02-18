//
//  BLButton.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLButton.h"

@interface BLButton ()

@property (nonatomic, assign, readwrite) BLButtonAlignment bl_buttonAlignment;
@property (nonatomic, assign, readwrite) CGFloat bl_buttonAlignmentGuide;
@property (nonatomic, assign, readwrite) CGFloat bl_buttonAlignmentMargin;
@property (nonatomic, assign, readwrite) CGFloat bl_buttonAlignmentMaxImageDimension;
@property (nonatomic, copy) BLButtonBlock block;

@end

@implementation BLButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) return nil;
    
    self.bl_buttonAlignment = BLButtonAlignmentDefault;
    self.bl_buttonAlignmentGuide = 0;
    self.bl_buttonAlignmentMargin = 0;
    
    return self;
}

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

- (void)bl_setButtonAlignment:(BLButtonAlignment)buttonAlignment guide:(CGFloat)guide maxImageDimension:(CGFloat)maxImageDimension margin:(CGFloat)margin
{
    self.bl_buttonAlignment = buttonAlignment;
    self.bl_buttonAlignmentGuide = guide;
    self.bl_buttonAlignmentMargin = margin;
    self.bl_buttonAlignmentMaxImageDimension = maxImageDimension;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    switch (self.bl_buttonAlignment) {
        case BLButtonAlignmentImageCenteredAboveTitle: {
            self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
            [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
            
            CGSize imageSize = [self imageForState:UIControlStateNormal].size;
            CGFloat const imageHeight = imageSize.height;
            CGFloat const imageWidth = imageSize.width;
            CGFloat const additionalMargin = ceil((self.bl_buttonAlignmentMaxImageDimension - imageHeight) / 2);
            CGFloat const imageLeftMargin = ceil((self.bounds.size.width - imageWidth) / 2);
            [self setImageEdgeInsets:UIEdgeInsetsMake(self.bl_buttonAlignmentGuide - self.bl_buttonAlignmentMargin - additionalMargin - imageHeight, imageLeftMargin, 0, 0)];
            [self setTitleEdgeInsets:UIEdgeInsetsMake(self.bl_buttonAlignmentGuide, -imageWidth, 0, 0)];
            
            break;
        }
            
        default:
            break;
    }
    
    [super layoutSubviews];
}

@end
