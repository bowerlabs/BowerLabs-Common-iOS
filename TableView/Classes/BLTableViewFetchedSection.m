//
//  BLTableViewFetchedSection.m
//  BowerLabsTableView
//
//  Created by Jeremy Bower on 2013-01-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLTableViewFetchedSection.h"
#import "BLTableViewSectionSubclass.h"

@interface BLTableViewFetchedSection () 

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end

@implementation BLTableViewFetchedSection

@synthesize fetchedResultsController = _fetchResultsController;

- (id)initWithFetchRequest:(NSFetchRequest*)fetchRequest
      managedObjectContext:(NSManagedObjectContext*)managedObjectContext
                 cacheName:(NSString*)cacheName
{
    self = [super init];
    if (self) {
        // Create the fetched results controller.
        self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest 
                                                                            managedObjectContext:managedObjectContext
                                                                              sectionNameKeyPath:nil
                                                                                       cacheName:cacheName];
        
        // Set the delegate to receive changes.
        self.fetchedResultsController.delegate = self;
        
        // Execute the fetch request.
        NSError *error = nil;
        BOOL success = [self.fetchedResultsController performFetch:&error];
        if (!success) {
            NSLog(@"Failed to perform fetch for table section: %@", error.localizedDescription);
        }
    }
    
    return self;
}

- (void)dealloc
{
    self.fetchedResultsController.delegate = nil;
}

#pragma mark - NSFetchResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller 
{
    [self postNotificationToUpdateSectionUsingBlock:^(BLTableView *tableView, NSUInteger sectionIndex) {
        [tableView beginUpdates];
    }];
}

- (void)controller:(NSFetchedResultsController *)controller 
   didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath 
     forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath 
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert: {
            [self postNotificationToUpdateSectionUsingBlock:^(BLTableView *tableView, NSUInteger sectionIndex) {
                NSIndexPath* sectionNewIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:sectionIndex];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:sectionNewIndexPath]
                                 withRowAnimation:self.insertRowAnimation];
            }];
            break;
        }
            
        case NSFetchedResultsChangeDelete: {
            [self postNotificationToUpdateSectionUsingBlock:^(BLTableView *tableView, NSUInteger sectionIndex) {
                NSIndexPath* sectionIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:sectionIndex];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:sectionIndexPath]
                                 withRowAnimation:self.deleteRowAnimation];
            }];
            break;
        }
            
        case NSFetchedResultsChangeUpdate: {
            [self postNotificationToUpdateSectionUsingBlock:^(BLTableView *tableView, NSUInteger sectionIndex) {
                NSIndexPath* sectionIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:sectionIndex];
                [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:sectionIndexPath]
                                 withRowAnimation:self.updateRowAnimation];
            }];
            break;
        }
            
        case NSFetchedResultsChangeMove: {
            [self postNotificationToUpdateSectionUsingBlock:^(BLTableView *tableView, NSUInteger sectionIndex) {
                NSIndexPath* sectionIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:sectionIndex];
                [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:sectionIndexPath]
                                 withRowAnimation:self.deleteRowAnimation];
                
                NSIndexPath* sectionNewIndexPath = [NSIndexPath indexPathForRow:newIndexPath.row inSection:sectionIndex];
                [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:sectionNewIndexPath]
                                 withRowAnimation:self.insertRowAnimation];
            }];
            break;
        }
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller 
{
    [self postNotificationToUpdateSectionUsingBlock:^(BLTableView *tableView, NSUInteger sectionIndex) {
        [tableView endUpdates];
    }];
}

#pragma mark - BLTableViewSection

- (NSUInteger)rowCount
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController.sections objectAtIndex:0];
    return sectionInfo.numberOfObjects;
}

- (id)rowAtIndex:(NSUInteger)index
{
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    return [self.fetchedResultsController objectAtIndexPath:indexPath];
}

@end
