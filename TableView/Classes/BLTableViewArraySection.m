//
//  BLTableViewArraySection.m
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewArraySection.h"
#import "BLTableViewSectionSubclass.h"

@interface BLTableViewArraySection ()

@property (nonatomic, strong) NSMutableArray* rows;
@property (nonatomic, strong) NSMutableIndexSet* hiddenRowIndexes;

@end

@implementation BLTableViewArraySection

@synthesize rows = _rows;
@synthesize hiddenRowIndexes = _hiddenRowIndexes;

- (id)init
{
    self = [super init];
    if (self) {
        self.rows = [NSMutableArray array];
    }
    
    return self;
}

- (NSUInteger)rowCount
{
    return self.rows.count;
}

- (id)rowAtIndex:(NSUInteger)index
{
    return [self.rows objectAtIndex:index];
}

- (void)addRow:(id)row
{
    [self.rows addObject:row];
}

- (void)insertRow:(id)row atIndex:(NSUInteger)index
{
    [self.rows insertObject:row atIndex:index];
}

- (void)removeRowAtIndex:(NSUInteger)index
{
    [self.rows removeObjectAtIndex:index];
}

- (void)replaceRowAtIndex:(NSUInteger)index withRow:(id)row
{
    [self.rows replaceObjectAtIndex:index withObject:row];
}

- (NSUInteger)absoluteRowIndexFromVisibleIndex:(NSUInteger)visibleIndex
{
    __block NSUInteger absoluteIndex = visibleIndex;
    [self.hiddenRowIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx <= absoluteIndex) {
            absoluteIndex++;
        }
        else {
            *stop = YES;
        }
    }];
    
    return absoluteIndex;
}

- (NSUInteger)hiddenRowCount
{
    return self.hiddenRowIndexes.count;
}

@end
