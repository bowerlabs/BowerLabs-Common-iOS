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
    
    switch (buttonAlignment) {
        case BLButtonAlignmentImageCenteredAboveTitle: {
            break;
        }
            
        case BLButtonAlignmentImageCenteredLeftTextCenteredRight: {
            [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
            break;
        }
            
        default:
            break;
    }
    
    self.bl_buttonAlignment = buttonAlignment;
    self.bl_buttonAlignmentGuide = guide;
    self.bl_buttonAlignmentMargin = margin;
    self.bl_buttonAlignmentMaxImageDimension = maxImageDimension;
    
    [self setNeedsLayout];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    switch (self.bl_buttonAlignment) {
        case BLButtonAlignmentImageCenteredAboveTitle: {
            CGFloat const titleLabelW = self.titleLabel.bounds.size.width;
            CGFloat const titleLabelH = self.titleLabel.bounds.size.height;
            CGFloat const titleLabelX = floor((self.bounds.size.width - titleLabelW) / 2);
            CGFloat const titleLabelY = self.bl_buttonAlignmentGuide;
            self.titleLabel.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
            
            CGSize imageSize = [self imageForState:UIControlStateNormal].size;
            CGFloat const imageViewW = imageSize.width;
            CGFloat const imageViewH = imageSize.height;
            CGFloat const additionalMargin = ceil((self.bl_buttonAlignmentMaxImageDimension - imageViewH) / 2);
            CGFloat const imageViewX = floor((self.bounds.size.width - imageViewW) / 2);
            CGFloat const imageViewY = titleLabelX - imageViewH - additionalMargin - self.bl_buttonAlignmentMargin;
            self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
            
            break;
        }
            
        case BLButtonAlignmentImageCenteredLeftTextCenteredRight: {
            CGFloat const titleLabelW = self.bounds.size.width - self.bl_buttonAlignmentGuide;
            CGFloat const titleLabelH = self.bounds.size.height;
            CGFloat const titleLabelX = self.bl_buttonAlignmentGuide;
            self.titleLabel.frame = CGRectMake(titleLabelX, 0, titleLabelW, titleLabelH);
            
            CGFloat const imageViewW = self.bl_buttonAlignmentGuide;
            CGFloat const imageViewH = self.bounds.size.height;
            self.imageView.frame = CGRectMake(0, 0, imageViewW, imageViewH);
            
            break;
        }
            
        default:
            break;
    }
}

@end
