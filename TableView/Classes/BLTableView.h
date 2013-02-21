//
//  BLTableView.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLTableViewAdapter;

@interface BLTableView : UIScrollView

@property (nonatomic, strong) BLTableViewAdapter* adapter;

@end
