//
//  BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-03-06.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

NSString* mangleKeyName(Class c, NSString* key) {
    NSString* className = NSStringFromClass(c);
    return [NSString stringWithFormat:@"%@_%@", className, key];
}
