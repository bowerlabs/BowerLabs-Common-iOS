//
//  BLTableViewSectionSubclass.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableView.h"

@interface BLTableViewSection (ForSubclassEyesOnly)

- (void)postNotificationToUpdateSectionUsingBlock:(BLTableViewUpdateSectionBlock)block;

- (void)postNotificationToUpdateRow:(NSIndexPath*)indexPath usingBlock:(BLTableViewUpdateRowBlock)block;

@end