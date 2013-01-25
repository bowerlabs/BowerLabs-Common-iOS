//
//  BLLocalization.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-01-24.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLLocalization.h"

NSString* BLLocalizedPluralizedString(NSInteger c, NSString* none, NSString* singular, NSString* plural, ...)
{
    NSString* value = (c == 0 ?
                       NSLocalizedString(none, nil) :
                       (c == 1 ?
                        NSLocalizedString(singular, nil) :
                        NSLocalizedString(plural, nil)));
    
    va_list args;
    va_start(args, plural);
    NSString *s = [[NSString alloc] initWithFormat:value arguments:args];
    va_end(args);
    return s;
}
