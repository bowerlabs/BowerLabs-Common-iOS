//
//  BLTableViewAdapter.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLTableViewAdapter : NSObject <UITableViewDelegate, UITableViewDataSource>

- (id)initWithViewController:(UIViewController*)viewController
           tableViewContents:(NSArray*)tableViewContents;

@end
