//
//  BLTextField.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-02-06.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTextField.h"

#import "UIApplication+BowerLabsUIKit.h"

@implementation BLTextField

- (void) drawPlaceholderInRect:(CGRect)rect {
    if (self.placeholderColor) {
        if ([UIApplication isOS7]) {
            // Create the paragraph style.
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            paragraphStyle.lineBreakMode = NSLineBreakByClipping;
            paragraphStyle.alignment = NSTextAlignmentLeft;
            
            // Create the attributes.
            NSDictionary* attributes = @{ NSFontAttributeName: self.font,
                                          NSForegroundColorAttributeName: self.placeholderColor,
                                          NSParagraphStyleAttributeName: paragraphStyle };
            
            // Get the height of the text.
            CGSize textSize = [self.placeholder sizeWithAttributes:attributes];
            CGFloat dy = floor((rect.size.height - textSize.height) / 2.0f);
            if (dy > 0) {
                rect = CGRectOffset(rect, 0, dy);
            }
            
            // Draw the text.
            [self.placeholder drawInRect:rect withAttributes:attributes];
        }
        else {
            [self.placeholderColor setFill];
            [self.placeholder drawInRect:rect withFont:self.font lineBreakMode:NSLineBreakByClipping alignment:self.textAlignment];
        }
    }
    else {
        [super drawPlaceholderInRect:rect];
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.contentInsets.left,
                      bounds.origin.y + self.contentInsets.top,
                      bounds.size.width - self.contentInsets.left - self.contentInsets.right,
                      bounds.size.height - self.contentInsets.top - self.contentInsets.bottom);
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + self.contentInsets.left,
                      bounds.origin.y + self.contentInsets.top,
                      bounds.size.width - self.contentInsets.left - self.contentInsets.right,
                      bounds.size.height - self.contentInsets.top - self.contentInsets.bottom);
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return CGRectMake(bounds.origin.x + self.contentInsets.left,
                      bounds.origin.y + self.contentInsets.top,
                      bounds.size.width - self.contentInsets.left - self.contentInsets.right,
                      bounds.size.height - self.contentInsets.top - self.contentInsets.bottom);
}

@end
