//
//  BLScrollingTabBar.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-05-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const BLScrollingTabBarDidSelectItemNotification;
extern NSString* const BLScrollingTabBarItemKeyName;

@interface BLScrollingTabBar : UIView

@property (nonatomic, strong) UIImage* leftEndCapImage;
@property (nonatomic, strong) UIImage* rightEndCapImage;
@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong, readonly) id selectedItem;

@end
