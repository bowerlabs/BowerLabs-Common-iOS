//
//  BLTableViewSection.m
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewSection.h"
#import "BLTableViewSectionSubclass.h"

#import "BLTableView.h"

NSString* const BLTableViewSectionDidUpdateNotification = @"BLTableViewSectionDidUpdateNotification";
NSString* const BLTableViewSectionDidUpdateRowNotification = @"BLTableViewSectionDidUpdateRowNotification";

NSString* const BLTableViewSectionNotificationBlockKey = @"BLTableViewSectionNotificationBlockKey";
NSString* const BLTableViewSectionNotificationRowIndexKey = @"BLTableViewSectionNotificationRowIndexKey";

NSString* const BLTableViewSectionNoCellFactoryOrSubclassException = @"BLTableViewSectionNoCellFactoryOrSubclassException";

@interface BLTableViewSection ()

@end

@implementation BLTableViewSection (ForPrivateEyesOnly)

- (NSUInteger)absoluteRowIndexFromVisibleIndex:(NSUInteger)index
{
    return index;
}

- (NSUInteger)hiddenRowCount
{
    return 0;
}

- (CGFloat)viewController:(UIViewController*)viewController
                tableView:(UITableView*)tableView
  heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger absoluteIndex = [self absoluteRowIndexFromVisibleIndex:indexPath.row];
    return [self viewController:viewController tableView:tableView heightForRowAtIndex:absoluteIndex];
}

- (UITableViewCell*)viewController:(UIViewController*)viewController
                         tableView:(UITableView*)tableView
             cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    NSUInteger absoluteIndex = [self absoluteRowIndexFromVisibleIndex:indexPath.row];
    return [self viewController:viewController tableView:tableView cellForRowAtIndex:absoluteIndex];
}

@end

@implementation BLTableViewSection (ForSubclassEyesOnly)

- (void)postNotificationToUpdateSectionUsingBlock:(BLTableViewUpdateSectionBlock)block
{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[block copy] forKey:BLTableViewSectionNotificationBlockKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BLTableViewSectionDidUpdateNotification
                                                        object:self
                                                      userInfo:userInfo];
}

- (void)postNotificationToUpdateRow:(NSIndexPath*)indexPath
                         usingBlock:(BLTableViewUpdateRowBlock)block
{
    NSMutableDictionary* userInfo = [NSMutableDictionary dictionary];
    [userInfo setObject:[block copy] forKey:BLTableViewSectionNotificationBlockKey];
    [userInfo setObject:indexPath forKey:BLTableViewSectionNotificationRowIndexKey];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:BLTableViewSectionDidUpdateRowNotification
                                                        object:self
                                                      userInfo:userInfo];
}

@end

@implementation BLTableViewSection

- (id)init
{
    self = [super init];
    if (self) {
        self.sectionHeaderHeight = 0;
        self.insertRowAnimation = UITableViewRowAnimationNone;
        self.deleteRowAnimation = UITableViewRowAnimationNone;
        self.updateRowAnimation = UITableViewRowAnimationNone;
    }
    
    return self;
}

- (NSUInteger)rowCount
{
    return 0;
}

- (id)rowAtIndex:(NSUInteger)index
{
    return nil;
}

- (CGFloat)viewController:(UIViewController*)viewController
                tableView:(UITableView*)tableView
      heightForRowAtIndex:(NSUInteger)index
{
    // Subclasses should override this method to customize row heights.
    return tableView.rowHeight;
}

- (UITableViewCell*)viewController:(UIViewController*)viewController
                         tableView:(UITableView*)tableView
                 cellForRowAtIndex:(NSUInteger)index
{
    // Get the row.
    id row = [self rowAtIndex:index];
    
    // Check if the row is a BLTableViewCell subclass.
    if ([row isKindOfClass:[UITableViewCell class]]) {
        return row;
    }
    
    // Check if there is a cell factory block.
    if (self.cellFactoryBlock) {
        return self.cellFactoryBlock(viewController, tableView, row);
    }
    
    // A subclass must implement this method or provice a cell factory block.
    [NSException raise:BLTableViewSectionNoCellFactoryOrSubclassException
                format:@"Provide either a cellFactoryBlock or subclass BLTableViewSection and implement viewController:tableView:cellForRowAtIndexPath:"];
    return nil;
}

@end
