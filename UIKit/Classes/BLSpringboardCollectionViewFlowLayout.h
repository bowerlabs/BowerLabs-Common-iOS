//
//  BLSpringboardCollectionViewFlowLayout.h
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-06-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BLSpringboardCollectionViewDataSource <UICollectionViewDataSource>

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath;

@optional

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath didMoveToIndexPath:(NSIndexPath *)toIndexPath;

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath;

@end

@protocol BLSpringboardCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>
@optional

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didBeginDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface BLSpringboardCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign, getter = isEditModeActive) BOOL editModeActive;
@property (assign, nonatomic) CGFloat scrollingSpeed;
@property (assign, nonatomic) UIEdgeInsets scrollingTriggerEdgeInsets;

@end
