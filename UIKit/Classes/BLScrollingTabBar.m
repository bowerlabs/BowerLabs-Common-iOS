//
//  BLScrollingTabBar.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-05-29.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "BLScrollingTabBar.h"

NSString* const BLScrollingTabBarDidSelectItemNotification = @"BLScrollingTabBarDidSelectItemNotification";
NSString* const BLScrollingTabBarItemKeyName = @"BLScrollingTabBarItemKeyName";

@interface BLScrollingTabBar () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UIImageView* leftEndCapImageView;
@property (nonatomic, strong) UIImageView* rightEndCapImageView;

@end

@implementation BLScrollingTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (!self) { return nil; }
    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
    self.collectionView.allowsSelection = YES;
    self.collectionView.allowsMultipleSelection = NO;
    self.collectionView.scrollEnabled = YES;
    self.collectionView.alwaysBounceHorizontal = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self addSubview:self.collectionView];
    
    [self setupCollectionView:self.collectionView];
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self updateCollectionView:self.collectionView];
}

#pragma mark - Collection view

- (void)setupCollectionView:(UICollectionView*)collectionView
{
    [NSException raise:@"Not Implemented" format:@"[%@ setupCollectionView:]", NSStringFromClass([self class])];
}

- (void)updateCollectionView:(UICollectionView*)collectionView
{
}

#pragma mark - Items

- (void)setItems:(NSArray *)items
{
    // Get the current selection.
    NSIndexPath* selectedItemIndexPath = [[self.collectionView indexPathsForSelectedItems] firstObject];
    
    // Set the new items.
    _items = items;
    [self.collectionView reloadData];
    
    // Select the same index if possible.
    if (items.count > 0) {
        NSInteger row = (selectedItemIndexPath.row < items.count ?
                         selectedItemIndexPath.row : 0);
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        
        [self.collectionView selectItemAtIndexPath:indexPath
                                          animated:NO
                                    scrollPosition:UICollectionViewScrollPositionNone];
        
        [self collectionView:self.collectionView didSelectItemAtIndexPath:indexPath];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    [NSException raise:@"Not Implemented" format:@"[%@ collectionView:cellForItemAtIndexPath:]", NSStringFromClass([self class])];
    return nil;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    [NSException raise:@"Not Implemented" format:@"[%@ collectionView:layout:sizeForItemAtIndexPath:]", NSStringFromClass([self class])];
    return CGSizeZero;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [self.items objectAtIndex:indexPath.row];
    NSDictionary* userInfo = @{ BLScrollingTabBarItemKeyName: item };
    [[NSNotificationCenter defaultCenter] postNotificationName:BLScrollingTabBarDidSelectItemNotification
                                                        object:self
                                                      userInfo:userInfo];
}

@end
