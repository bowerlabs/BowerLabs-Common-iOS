//
//  BLTableViewFetchedSection.h
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewSection.h"

@interface BLTableViewFetchedSection : BLTableViewSection <NSFetchedResultsControllerDelegate>

- (id)initWithFetchRequest:(NSFetchRequest*)fetchRequest
      managedObjectContext:(NSManagedObjectContext*)managedObjectContext
                 cacheName:(NSString*)cacheName;

@end
