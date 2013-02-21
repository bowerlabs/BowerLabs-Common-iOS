//
//  NSMutableAttributedString+BowerLabsFoundation.h
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-02-19.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (BowerLabsFoundation)

- (void)appendString:(NSString*)str attributes:(NSDictionary*)attributes;

@end
