//
//  NSDictionary+BowerLabsFoundation.m
//  BowerLabsFoundation
//
//  Created by Jeremy Bower on 2013-02-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "NSDictionary+BowerLabsFoundation.h"

@implementation NSDictionary (BowerLabsFoundation)

- (NSDictionary*)bl_dictionaryByMerging:(NSDictionary*)dictionary
{
    NSMutableDictionary* mergedDictionary = [NSMutableDictionary dictionaryWithDictionary:self];
    [mergedDictionary addEntriesFromDictionary:dictionary];
    return mergedDictionary;
}

@end
