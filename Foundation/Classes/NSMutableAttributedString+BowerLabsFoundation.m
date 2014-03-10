//
//  NSMutableAttributedString+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-02-19.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSMutableAttributedString+BowerLabsFoundation.h"

@implementation NSMutableAttributedString (BowerLabsFoundation)

- (void)bl_appendString:(NSString*)str attributes:(NSDictionary*)attributes
{
    if (str) {
        NSAttributedString* attributedString = [[NSAttributedString alloc] initWithString:str attributes:attributes];
        [self appendAttributedString:attributedString];
    }
}

@end
