//
//  BLSpringboardCollectionViewLayoutAttributes.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-06-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLSpringboardCollectionViewLayoutAttributes.h"

@implementation BLSpringboardCollectionViewLayoutAttributes

- (id)copyWithZone:(NSZone *)zone
{
    BLSpringboardCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.editModeActive = _editModeActive;
    return attributes;
}

@end
