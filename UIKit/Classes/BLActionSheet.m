//
//  BLActionSheet.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLActionSheet.h"

@implementation BLActionItem

+ (BLActionItem*)actionItemWithTitle:(NSString*)title
{
    return [BLActionItem actionItemWithTitle:title block:nil];
}

+ (BLActionItem*)actionItemWithTitle:(NSString*)title block:(BLActionItemBlock)block
{
    return [[BLActionItem alloc] initWithTitle:title block:block];
}

- (id)initWithTitle:(NSString*)title block:(BLActionItemBlock)block
{
    self = [super init];
    if (self) {
        self.title = title;
        self.block = block;
    }
    
    return self;
}

@end

@implementation BLActionSheet

+ (BLActionSheet*)actionSheetWithTitle:(NSString *)title
                             cancelItem:(BLActionItem*)cancelItem
                        destructiveItem:(BLActionItem*)destructiveItem
                             otherItems:(NSArray*)otherItems
{
    return [[BLActionSheet alloc] initWithTitle:title
                                      cancelItem:cancelItem
                                 destructiveItem:destructiveItem
                                      otherItems:otherItems];
}

- (id)initWithTitle:(NSString *)title 
         cancelItem:(BLActionItem*)cancelItem
    destructiveItem:(BLActionItem*)destructiveItem
         otherItems:(NSArray*)otherItems
{
    self = [super initWithTitle:title delegate:self 
              cancelButtonTitle:nil
         destructiveButtonTitle:nil
              otherButtonTitles:nil];
    
    if (self) {
        NSMutableArray* items = [NSMutableArray arrayWithCapacity:(otherItems.count + (destructiveItem ? 1 : 0) + (cancelItem ? 1 : 0))];
        
        if (destructiveItem) {
            [items addObject:destructiveItem];
        }
        
        if (otherItems) {
            [items addObjectsFromArray:otherItems];
        }
        
        if (cancelItem) {
            [items addObject:cancelItem];
        }
        
        self.items = items;
        
        [self.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BLActionItem* item = obj;
            [self addButtonWithTitle:item.title];
        }];
        
        if (destructiveItem) {
            self.destructiveButtonIndex = 0;
        }
        
        if (cancelItem) {
            self.cancelButtonIndex = self.items.count - 1;
        }
    }
    
    return self;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (0 <= buttonIndex && buttonIndex < self.items.count) {
        BLActionItem* item = [self.items objectAtIndex:buttonIndex];
        if (item.block) {
            item.block();
        }
    }
}

@end
