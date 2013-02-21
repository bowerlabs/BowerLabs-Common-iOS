//
//  BLTableViewCell.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BLTableViewCell;

typedef void (^BLTableViewCellSelectionBlock)(UIViewController*, UITableView*, NSIndexPath*, BLTableViewCell*);

@interface BLTableViewCell : UITableViewCell

@property (nonatomic, copy) BLTableViewCellSelectionBlock selectionBlock;

@end
