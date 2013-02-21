//
//  BLTableViewAdapter.m
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewAdapter.h"

@interface BLTableViewAdapter ()

@property (nonatomic, strong) UIViewController* viewController;
@property (nonatomic, strong) NSArray* tableViewContents;

@end

@implementation BLTableViewAdapter

- (id)initWithViewController:(UIViewController *)viewController
           tableViewContents:(NSArray*)tableViewContents
{
    self = [super init];
    if (!self) return nil;
    
    self.viewController = viewController;
    self.tableViewContents = [tableViewContents copy];
    
    return self;
}

#pragma mark - UITableViewDelegate

#pragma mark - UITableViewDataSource

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
