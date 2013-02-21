//
//  BLTableViewSectionPrivate.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableView.h"

@class BLTableViewDataSource;

@interface BLTableViewSection (ForPrivateEyesOnly)

- (NSUInteger)absoluteRowIndexFromVisibleIndex:(NSUInteger)index;

- (NSUInteger)hiddenRowCount;

- (CGFloat)viewController:(UIViewController*)viewController
                tableView:(UITableView*)tableView
  heightForRowAtIndexPath:(NSIndexPath*)indexPath;

- (UITableViewCell*)viewController:(UIViewController*)viewController
                         tableView:(UITableView*)tableView
             cellForRowAtIndexPath:(NSIndexPath*)indexPath;

@end