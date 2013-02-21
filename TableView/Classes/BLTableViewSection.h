//
//  TableViewSection.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLTableView;

extern NSString* const BLTableViewSectionDidUpdateNotification;
extern NSString* const BLTableViewSectionDidUpdateRowNotification;

extern NSString* const BLTableViewSectionNotificationBlockKey;
extern NSString* const BLTableViewSectionNotificationRowIndexKey;

typedef UITableViewCell*(^BLTableViewSectionCellFactoryBlock)(UIViewController*, UITableView*, id);

@interface BLTableViewSection : NSObject

@property (nonatomic, strong) NSString* sectionHeaderTitle;
@property (nonatomic, strong) UIView* sectionHeaderView;
@property (nonatomic, assign) CGFloat sectionHeaderHeight;
@property (nonatomic, copy) BLTableViewSectionCellFactoryBlock cellFactoryBlock;

@property (nonatomic, assign) UITableViewRowAnimation insertRowAnimation;
@property (nonatomic, assign) UITableViewRowAnimation deleteRowAnimation;
@property (nonatomic, assign) UITableViewRowAnimation updateRowAnimation;

- (NSUInteger)rowCount;
- (id)rowAtIndex:(NSUInteger)index;

- (CGFloat)viewController:(UIViewController*)viewController
                tableView:(UITableView*)tableView
      heightForRowAtIndex:(NSUInteger)index;

- (UITableViewCell*)viewController:(UIViewController*)viewController
                         tableView:(UITableView*)tableView
                 cellForRowAtIndex:(NSUInteger)index;

@end
