//
//  BLAlertView.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLAlertView.h"

@interface BLAlertItem ()

@property (nonatomic, strong) NSString* title;
@property (nonatomic, copy) BLAlertItemBlock block;

@end

@implementation BLAlertItem

+ (BLAlertItem*)alertItemWithTitle:(NSString*)title
{
    return [BLAlertItem alertItemWithTitle:title block:nil];
}

+ (BLAlertItem*)alertItemWithTitle:(NSString*)title block:(BLAlertItemBlock)block
{
    return [[BLAlertItem alloc] initWithTitle:title block:block];
}

- (id)initWithTitle:(NSString*)title block:(BLAlertItemBlock)block
{
    self = [super init];
    if (self) {
        self.title = title;
        self.block = block;
    }
    
    return self;
}

@end

@interface BLAlertView ()

@property (nonatomic, retain) NSArray* items;

@end

@implementation BLAlertView

#pragma mark - Create and return a BLAlertView

+ (BLAlertView*)alertViewWithTitle:(NSString *)title 
                            message:(NSString *)message
                          itemTitle:(NSString *)itemTitle
                          itemBlock:(BLAlertItemBlock)itemBlock
{
    return [BLAlertView alertViewWithTitle:title 
                                    message:message
                                 cancelItem:nil
                                 otherItems:[NSArray arrayWithObject:[BLAlertItem alertItemWithTitle:itemTitle 
                                                                                                block:itemBlock]]];
}

+ (BLAlertView*)alertViewWithTitle:(NSString *)title 
                            message:(NSString *)message 
                         cancelItem:(BLAlertItem*)cancelItem
                         otherItems:(NSArray*)otherItems
{
    return [[BLAlertView alloc] initWithTitle:title message:message cancelItem:cancelItem otherItems:otherItems];
}

#pragma mark - Create and show a BLAlertView

+ (void)showAlertViewWithTitle:(NSString *)title 
                       message:(NSString *)message
                     itemTitle:(NSString *)itemTitle
                     itemBlock:(BLAlertItemBlock)itemBlock
{
    [[BLAlertView alertViewWithTitle:title message:message itemTitle:itemTitle itemBlock:itemBlock] show];
}

+ (void)showAlertViewWithTitle:(NSString *)title 
                       message:(NSString *)message 
                    cancelItem:(BLAlertItem*)cancelItem
                    otherItems:(NSArray*)otherItems
{
    [[BLAlertView alertViewWithTitle:title message:message cancelItem:cancelItem otherItems:otherItems] show];
}

#pragma mark - Initialization

- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelItem:(BLAlertItem*)cancelItem otherItems:(NSArray*)otherItems
{
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelItem.title otherButtonTitles:nil];
    if (self) {
        NSMutableArray* items = [NSMutableArray arrayWithCapacity:(otherItems.count + (cancelItem ? 1 : 0))];
        if (cancelItem) {
            [items addObject:cancelItem];
        }
        
        if (otherItems) {
            [items addObjectsFromArray:otherItems];
        }
        
        self.items = items;
        
        [otherItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            BLAlertItem* item = obj;
            [self addButtonWithTitle:item.title];
        }];
    }
    
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (0 <= buttonIndex && buttonIndex < self.items.count) {
        BLAlertItem* item = [self.items objectAtIndex:buttonIndex];
        if (item.block) {
            item.block();
        }
    }
}

@end
