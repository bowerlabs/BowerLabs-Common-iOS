//
//  BLActionSheet.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLActionItemBlock)();

@interface BLActionItem : NSObject

@property (nonatomic, strong) NSString* title;
@property (nonatomic, copy) BLActionItemBlock block;

+ (BLActionItem*)actionItemWithTitle:(NSString*)title;

+ (BLActionItem*)actionItemWithTitle:(NSString*)title block:(BLActionItemBlock)block;

- (id)initWithTitle:(NSString*)title block:(BLActionItemBlock)block;

@end

@interface BLActionSheet : UIActionSheet <UIActionSheetDelegate>

@property (nonatomic, strong) NSArray* items;

+ (BLActionSheet*)actionSheetWithTitle:(NSString *)title
                            cancelItem:(BLActionItem*)cancelItem
                       destructiveItem:(BLActionItem*)destructiveItem
                            otherItems:(NSArray*)otherItems;

- (id)initWithTitle:(NSString *)title
         cancelItem:(BLActionItem*)cancelItem
    destructiveItem:(BLActionItem*)destructiveItem
         otherItems:(NSArray*)otherItems;

@end
