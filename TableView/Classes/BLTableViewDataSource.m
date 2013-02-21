//
//  BLTableViewDataSource.m
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewDataSource.h"

#import "BLTableView.h"
#import "BLTableViewSection.h"
#import "BLTableViewSectionPrivate.h"

NSString* const BLTableViewDataSourceDidUpdateSectionNotification = @"BLTableViewDataSourceDidUpdateSectionNotification";
NSString* const BLTableViewDataSourceDidUpdateRowNotification = @"BLTableViewDataSourceDidUpdateRowNotification";

NSString* const BLTableViewDataSourceNotificationBlockKey = @"BLTableViewDataSourceNotificationBlockKey";
NSString* const BLTableViewDataSourceNotificationSectionIndexKey = @"BLTableViewDataSourceNotificationSectionIndexKey";
NSString* const BLTableViewDataSourceNotificationIndexPathKey = @"BLTableViewDataSourceNotificationIndexPathKey";

@interface BLTableViewDataSource ()

@property (nonatomic, weak, readwrite) UIViewController* viewController;
@property (nonatomic, strong) NSMutableArray* sections;
@property (nonatomic, strong) NSMutableIndexSet* hiddenSectionIndexes;

@end

@implementation BLTableViewDataSource

- (id)initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
        
        // Allocate arrays for sections.
        self.sections = [NSMutableArray array];
        self.hiddenSectionIndexes = [NSMutableIndexSet indexSet];
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Sections

- (NSUInteger)visibleSectionIndexFromAbsoluteIndex:(NSUInteger)index
{
    NSUInteger hiddenCount = [self.hiddenSectionIndexes countOfIndexesInRange:NSMakeRange(0, index)];
    return index - hiddenCount;
}

- (NSUInteger)absoluteSectionIndexFromVisibleIndex:(NSUInteger)visibleIndex
{
    __block NSUInteger absoluteIndex = visibleIndex;
    [self.hiddenSectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx <= absoluteIndex) {
            absoluteIndex++;
        }
        else {
            *stop = YES;
        }
    }];
    
    return absoluteIndex;
}

- (NSUInteger)sectionCount
{
    return [self.sections count];
}

- (NSUInteger)hiddenSectionCount
{
    return self.hiddenSectionIndexes.count;
}

- (NSUInteger)indexOfSection:(BLTableViewSection*)section
{
    return [self.sections indexOfObject:section];
}

- (BLTableViewSection*)sectionAtIndexPath:(NSIndexPath*)indexPath
{
    return [self sectionAtIndex:indexPath.section];
}

- (BLTableViewSection*)sectionAtIndex:(NSUInteger)index
{
    NSUInteger absoluteIndex = [self absoluteSectionIndexFromVisibleIndex:index];
    return [self.sections objectAtIndex:absoluteIndex];
}

- (void)addSection:(BLTableViewSection*)section 
{
    [self.sections addObject:section];
    [self addObserverForSection:section];
}

- (void)insertSection:(BLTableViewSection*)section atIndex:(NSUInteger)index
{
    [self.sections insertObject:section atIndex:index];
    [self addObserverForSection:section];
}

- (void)removeSectionAtIndex:(NSUInteger)index
{
    BLTableViewSection* section = [self.sections objectAtIndex:index];
    [self removeObserverForSection:section];
    [self.sections removeObjectAtIndex:index];
}

- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(BLTableViewSection*)section
{
    BLTableViewSection* oldSection = [self.sections objectAtIndex:index];
    if (section != oldSection) {
        [self removeObserverForSection:oldSection];
        
        [self.sections replaceObjectAtIndex:index withObject:section];
        [self addObserverForSection:section];
    }
}

- (void)setSection:(BLTableViewSection*)section hidden:(BOOL)hidden
{
    NSUInteger index = [self indexOfSection:section];
    [self setSectionAtIndex:index hidden:hidden];
}

- (void)setSectionAtIndex:(NSUInteger)index hidden:(BOOL)hidden
{
    void(^postNotification)() = ^{
        // TODO
    };
    
    if ([self isHiddenSectionAtIndex:index]) {
        if (!hidden) {
            [self.hiddenSectionIndexes removeIndex:index];
            postNotification();
        }
    }
    else {
        if (hidden) {
            [self.hiddenSectionIndexes addIndex:index];
            postNotification();
        }
    }
}

- (BOOL)isHiddenSection:(BLTableViewSection*)section
{
    NSUInteger index = [self indexOfSection:section];
    return [self isHiddenSectionAtIndex:index];
}

- (BOOL)isHiddenSectionAtIndex:(NSUInteger)index
{
    return [self.hiddenSectionIndexes containsIndex:index];
}

#pragma mark - Notifications

- (void)postNotificationToUpdateSection:(NSUInteger)index 
                             usingBlock:(BLTableViewUpdateSectionBlock)block
{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[block copy] forKey:BLTableViewDataSourceNotificationBlockKey];
    [userInfo setObject:[NSNumber numberWithUnsignedInteger:index] forKey:BLTableViewDataSourceNotificationSectionIndexKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BLTableViewDataSourceDidUpdateSectionNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)postNotificationToUpdateRow:(NSIndexPath*)indexPath 
                         usingBlock:(BLTableViewUpdateRowBlock)block
{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[block copy] forKey:BLTableViewDataSourceNotificationBlockKey];
    [userInfo setObject:indexPath forKey:BLTableViewDataSourceNotificationIndexPathKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BLTableViewDataSourceDidUpdateRowNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)addObserverForSection:(BLTableViewSection*)section
{
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(sectionDidUpdateNotification:) 
                                                 name:BLTableViewSectionDidUpdateNotification 
                                               object:section];
    
    [[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(sectionDidUpdateRowNotification:) 
                                                 name:BLTableViewSectionDidUpdateRowNotification 
                                               object:section];
}

- (void)removeObserverForSection:(BLTableViewSection*)section
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:nil object:section];
}

- (void)sectionDidUpdateNotification:(NSNotification*)notification
{
    // Unpack the notification.
    BLTableViewUpdateSectionBlock block = [notification.userInfo objectForKey:BLTableViewSectionNotificationBlockKey];
    
    // Find the section.
    BLTableViewSection* section = notification.object;
    NSUInteger sectionIndex = [self indexOfSection:section];

    // Notify the table view.
    [self postNotificationToUpdateSection:sectionIndex usingBlock:block];
}

- (void)sectionDidUpdateRowNotification:(NSNotification*)notification
{
    // Unpack the notification.
    NSUInteger rowIndex = [[notification.userInfo objectForKey:BLTableViewSectionNotificationRowIndexKey] unsignedIntegerValue];
    BLTableViewUpdateRowBlock block = [notification.userInfo objectForKey:BLTableViewDataSourceNotificationBlockKey];
    
    // Find the section.
    BLTableViewSection* section = notification.object;
    NSUInteger sectionIndex = [self indexOfSection:section];

    // Notify the table view.
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:sectionIndex];
    [self postNotificationToUpdateRow:indexPath usingBlock:block];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Count only the visible sections.
    NSInteger count = [self sectionCount] - [self hiddenSectionCount];
    return count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)index
{
    // Get the section.
    NSUInteger absoluteIndex = [self absoluteSectionIndexFromVisibleIndex:index];
    BLTableViewSection* section = [self.sections objectAtIndex:absoluteIndex];
    
    // Count only the visible rows.
    NSInteger count = [section rowCount] - [section hiddenRowCount];
    return count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the section.
    NSUInteger absoluteSectionIndex = [self absoluteSectionIndexFromVisibleIndex:indexPath.section];
    BLTableViewSection* section = [self.sections objectAtIndex:absoluteSectionIndex];
    
    // Get the row.
    NSUInteger absoluteRowIndex = [section absoluteRowIndexFromVisibleIndex:indexPath.row];
    id row = [section rowAtIndex:absoluteRowIndex];
    
    // Check if the row is a UITableViewCell subclass.
    if ([row isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell*)row;
    }
    
    return [section viewController:self.viewController
                         tableView:tableView
             cellForRowAtIndexPath:indexPath];
}

@end
