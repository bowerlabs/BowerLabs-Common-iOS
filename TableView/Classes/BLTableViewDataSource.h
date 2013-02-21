//
//  BLTableViewDataSource.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BLTableViewSection;

extern NSString* const BLTableViewDataSourceDidUpdateSectionNotification;
extern NSString* const BLTableViewDataSourceDidUpdateRowNotification;

extern NSString* const BLTableViewDataSourceNotificationBlockKey;
extern NSString* const BLTableViewDataSourceNotificationSectionIndexKey;
extern NSString* const BLTableViewDataSourceNotificationIndexPathKey;

@interface BLTableViewDataSource : NSObject <UITableViewDataSource>

@property (nonatomic, weak, readonly) UIViewController* viewController;

- (id)initWithViewController:(UIViewController*)viewController;

- (NSUInteger)sectionCount;
- (NSUInteger)indexOfSection:(BLTableViewSection*)section;
- (BLTableViewSection*)sectionAtIndexPath:(NSIndexPath*)indexPath;
- (BLTableViewSection*)sectionAtIndex:(NSUInteger)index;
- (void)addSection:(BLTableViewSection*)section;
- (void)insertSection:(BLTableViewSection*)section atIndex:(NSUInteger)index;
- (void)removeSectionAtIndex:(NSUInteger)index;
- (void)replaceSectionAtIndex:(NSUInteger)index withSection:(BLTableViewSection*)section;

- (NSUInteger)hiddenSectionCount;
- (void)setSection:(BLTableViewSection*)section hidden:(BOOL)hidden;
- (void)setSectionAtIndex:(NSUInteger)index hidden:(BOOL)hidden;
- (BOOL)isHiddenSection:(BLTableViewSection*)section;
- (BOOL)isHiddenSectionAtIndex:(NSUInteger)index;

@end
