//
//  BLTableViewDelegate.m
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewDelegate.h"

#import "BLTableViewCell.h"
#import "BLTableViewSectionPrivate.h"

@interface BLTableViewDelegate ()

@property (nonatomic, weak) UIViewController* viewController;

@end

@implementation BLTableViewDelegate

- (id)initWithViewController:(UIViewController*)viewController
{
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    
    return self;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Get the cell.
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // Check if the cell has a selection block.
    if ([cell isKindOfClass:[BLTableViewCell class]]) {
        BLTableViewCell* selectableCell =  (BLTableViewCell*)cell;
        if (selectableCell.selectionBlock) {
            selectableCell.selectionBlock(self.viewController, tableView, indexPath, selectableCell);
        }
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath
{
    if ([tableView.dataSource isKindOfClass:[BLTableViewDataSource class]]) {
        BLTableViewDataSource* dataSource = (BLTableViewDataSource*)tableView.dataSource;
        BLTableViewSection* section = [dataSource sectionAtIndexPath:indexPath];
        return [section viewController:self.viewController
                             tableView:tableView
               heightForRowAtIndexPath:indexPath];
    }
    
    return tableView.rowHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if ([tableView.dataSource isKindOfClass:[BLTableViewDataSource class]]) {
        // Get the section.
        BLTableViewDataSource* dataSource = (BLTableViewDataSource*)tableView.dataSource;
        BLTableViewSection* section = [dataSource sectionAtIndex:sectionIndex];
        
        // Return the view.
        return section.sectionHeaderView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if ([tableView.dataSource isKindOfClass:[BLTableViewDataSource class]]) {
        // Get the section.
        BLTableViewDataSource* dataSource = (BLTableViewDataSource*)tableView.dataSource;
        BLTableViewSection* section = [dataSource sectionAtIndex:sectionIndex];
        
        // Return the height.
        return section.sectionHeaderHeight;
    }
    
    return 0;
}

@end
