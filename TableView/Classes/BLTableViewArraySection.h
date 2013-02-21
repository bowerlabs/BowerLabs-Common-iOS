//
//  BLTableViewArraySection.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewSection.h"

@interface BLTableViewArraySection : BLTableViewSection

- (void)addRow:(id)row;
- (void)insertRow:(id)row atIndex:(NSUInteger)index;
- (void)removeRowAtIndex:(NSUInteger)index;
- (void)replaceRowAtIndex:(NSUInteger)index withRow:(id)row;

@end
