//
//  BLAlertView.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BLAlertItemBlock)();

@interface BLAlertItem : NSObject 

+ (BLAlertItem*)alertItemWithTitle:(NSString*)title;

+ (BLAlertItem*)alertItemWithTitle:(NSString*)title block:(BLAlertItemBlock)block;

- (id)initWithTitle:(NSString*)title block:(BLAlertItemBlock)block;
    
@end

@interface BLAlertView : UIAlertView <UIAlertViewDelegate>

+ (BLAlertView*)alertViewWithTitle:(NSString *)title 
                            message:(NSString *)message 
                         cancelItem:(BLAlertItem*)cancelItem
                         otherItems:(NSArray*)otherItems;

+ (BLAlertView*)alertViewWithTitle:(NSString *)title 
                            message:(NSString *)message
                          itemTitle:(NSString *)itemTitle
                          itemBlock:(BLAlertItemBlock)itemBlock;

+ (BLAlertView*)showAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                             itemTitle:(NSString *)itemTitle
                             itemBlock:(BLAlertItemBlock)itemBlock;

+ (BLAlertView*)showAlertViewWithTitle:(NSString *)title
                               message:(NSString *)message
                            cancelItem:(BLAlertItem*)cancelItem
                            otherItems:(NSArray*)otherItems;

- (id)initWithTitle:(NSString *)title 
            message:(NSString *)message 
         cancelItem:(BLAlertItem*)cancelItem
         otherItems:(NSArray*)otherItems;

@end
