//
//  BLSpringboardCollectionViewFlowLayout.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-06-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "BLSpringboardCollectionViewFlowLayout.h"

#import "BLSpringboardCollectionViewLayoutAttributes.h"

CGFloat const BLSpringboardCollectionViewFPS = 60.0;

CG_INLINE CGPoint BL_CGPointAdd(CGPoint point1, CGPoint point2) {
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}

typedef NS_ENUM(NSInteger, BLScrollingDirection) {
    BLScrollingDirectionUnknown = 0,
    BLScrollingDirectionUp,
    BLScrollingDirectionDown,
    BLScrollingDirectionLeft,
    BLScrollingDirectionRight
};

static NSString * const BLScrollingDirectionKey = @"BLScrollingDirectionKey";
static NSString * const BLCollectionViewKeyPath = @"collectionView";

@interface UICollectionViewCell (BLSpringboardCollectionViewFlowLayout)

- (UIImage *)BL_rasterizedImage;

@end

@implementation UICollectionViewCell (BLSpringboardCollectionViewFlowLayout)

- (UIImage *)BL_rasterizedImage
{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0.0f);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

@interface BLSpringboardCollectionViewFlowLayout () <UIGestureRecognizerDelegate>

@property (assign, nonatomic, readonly) id<BLSpringboardCollectionViewDataSource> dataSource;
@property (assign, nonatomic, readonly) id<BLSpringboardCollectionViewDelegateFlowLayout> delegate;

@property (nonatomic, strong) UILongPressGestureRecognizer* longPressGestureRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;
@property (nonatomic, strong) UITapGestureRecognizer* tapGestureRecognizer;

@property (nonatomic, strong) NSIndexPath *selectedItemIndexPath;
@property (nonatomic, strong) UIView *currentView;
@property (nonatomic, assign) CGPoint currentViewCenter;
@property (nonatomic, assign) CGPoint panTranslationInCollectionView;
@property (nonatomic, strong) NSTimer *scrollingTimer;

@end

@implementation BLSpringboardCollectionViewFlowLayout

+ (Class)layoutAttributesClass
{
    return [BLSpringboardCollectionViewLayoutAttributes class];
}

- (id)init
{
    self = [super init];
    if (!self) { return nil; }
    
    [self setDefaults];
    [self addObserver:self forKeyPath:BLCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];

    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) { return nil; }
    
    [self setDefaults];
    [self addObserver:self forKeyPath:BLCollectionViewKeyPath options:NSKeyValueObservingOptionNew context:nil];

    return self;
}

- (void)dealloc
{
    [self invalidatesScrollTimer];
    [self removeObserver:self forKeyPath:BLCollectionViewKeyPath];
}

#pragma mark - Edit mode

- (void)setEditModeActive:(BOOL)editModeActive
{
    if (_editModeActive != editModeActive) {
        _editModeActive = editModeActive;
        [self invalidateLayout];
    }
}

#pragma mark - Setup and defaults

- (void)setDefaults
{
    self.scrollingSpeed = 300.0f;
    self.scrollingTriggerEdgeInsets = UIEdgeInsetsMake(50.0f, 50.0f, 50.0f, 50.0f);
}

- (void)setupCollectionView
{
    self.longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGestureAction:)];
    self.longPressGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:self.longPressGestureRecognizer];
    for (UIGestureRecognizer *gestureRecognizer in self.collectionView.gestureRecognizers) {
        if ([gestureRecognizer isKindOfClass:[UILongPressGestureRecognizer class]]) {
            [gestureRecognizer requireGestureRecognizerToFail:self.longPressGestureRecognizer];
        }
    }
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    self.panGestureRecognizer.delegate = self;
    [self.collectionView addGestureRecognizer:self.panGestureRecognizer];
    
    self.tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
    self.tapGestureRecognizer.delegate = self;
    [self.tapGestureRecognizer requireGestureRecognizerToFail:self.longPressGestureRecognizer];
    [self.tapGestureRecognizer requireGestureRecognizerToFail:self.panGestureRecognizer];
    [self.collectionView addGestureRecognizer:self.tapGestureRecognizer];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes
{
    if ([layoutAttributes.indexPath isEqual:self.selectedItemIndexPath]) {
        layoutAttributes.hidden = YES;
    }
}

#pragma mark - Data Source and Delegate

- (id<BLSpringboardCollectionViewDataSource>)dataSource {
    return (id<BLSpringboardCollectionViewDataSource>)self.collectionView.dataSource;
}

- (id<BLSpringboardCollectionViewDelegateFlowLayout>)delegate {
    return (id<BLSpringboardCollectionViewDelegateFlowLayout>)self.collectionView.delegate;
}

#pragma mark - Helpers

- (void)invalidateLayoutIfNecessary
{
    NSIndexPath *newIndexPath = [self.collectionView indexPathForItemAtPoint:self.currentView.center];
    NSIndexPath *previousIndexPath = self.selectedItemIndexPath;
    
    if ((newIndexPath == nil) || [newIndexPath isEqual:previousIndexPath]) {
        return;
    }
    
    if ([self.dataSource respondsToSelector:@selector(collectionView:itemAtIndexPath:canMoveToIndexPath:)] &&
        ![self.dataSource collectionView:self.collectionView itemAtIndexPath:previousIndexPath canMoveToIndexPath:newIndexPath]) {
        return;
    }
    
    self.selectedItemIndexPath = newIndexPath;
    
    // Required.
    [self.dataSource collectionView:self.collectionView itemAtIndexPath:previousIndexPath willMoveToIndexPath:newIndexPath];
    
    __weak typeof(self) weakSelf = self;
    [self.collectionView performBatchUpdates:^{
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf.collectionView deleteItemsAtIndexPaths:@[ previousIndexPath ]];
            [strongSelf.collectionView insertItemsAtIndexPaths:@[ newIndexPath ]];
        }
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self.dataSource respondsToSelector:@selector(collectionView:itemAtIndexPath:didMoveToIndexPath:)]) {
                [self.dataSource collectionView:self.collectionView itemAtIndexPath:previousIndexPath didMoveToIndexPath:newIndexPath];
            }
        }
    }];
}

- (void)invalidatesScrollTimer
{
    if (self.scrollingTimer.isValid) {
        [self.scrollingTimer invalidate];
    }
    self.scrollingTimer = nil;
}

- (void)setupScrollTimerInDirection:(BLScrollingDirection)direction
{
    if (self.scrollingTimer.isValid) {
        BLScrollingDirection oldDirection = [self.scrollingTimer.userInfo[BLScrollingDirectionKey] integerValue];
        if (direction == oldDirection) {
            return;
        }
    }
    
    [self invalidatesScrollTimer];
    
    self.scrollingTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 / BLSpringboardCollectionViewFPS
                                                           target:self
                                                         selector:@selector(handleScroll:)
                                                         userInfo:@{ BLScrollingDirectionKey : @(direction) }
                                                          repeats:YES];
}

#pragma mark - Scrolling

- (void)handleScroll:(NSTimer *)timer
{
    BLScrollingDirection direction = (BLScrollingDirection)[timer.userInfo[BLScrollingDirectionKey] integerValue];
    if (direction == BLScrollingDirectionUnknown) {
        return;
    }
    
    CGSize frameSize = self.collectionView.bounds.size;
    CGSize contentSize = self.collectionView.contentSize;
    CGPoint contentOffset = self.collectionView.contentOffset;
    CGFloat distance = self.scrollingSpeed / BLSpringboardCollectionViewFPS;
    CGPoint translation = CGPointZero;
    
    switch(direction) {
        case BLScrollingDirectionUp: {
            distance = -distance;
            CGFloat minY = 0.0f;
            
            if ((contentOffset.y + distance) <= minY) {
                distance = -contentOffset.y;
            }
            
            translation = CGPointMake(0.0f, distance);
        } break;
        case BLScrollingDirectionDown: {
            CGFloat maxY = MAX(contentSize.height, frameSize.height) - frameSize.height;
            
            if ((contentOffset.y + distance) >= maxY) {
                distance = maxY - contentOffset.y;
            }
            
            translation = CGPointMake(0.0f, distance);
        } break;
        case BLScrollingDirectionLeft: {
            distance = -distance;
            CGFloat minX = 0.0f;
            
            if ((contentOffset.x + distance) <= minX) {
                distance = -contentOffset.x;
            }
            
            translation = CGPointMake(distance, 0.0f);
        } break;
        case BLScrollingDirectionRight: {
            CGFloat maxX = MAX(contentSize.width, frameSize.width) - frameSize.width;
            
            if ((contentOffset.x + distance) >= maxX) {
                distance = maxX - contentOffset.x;
            }
            
            translation = CGPointMake(distance, 0.0f);
        } break;
        default: {
            // Do nothing...
        } break;
    }
    
    self.currentViewCenter = BL_CGPointAdd(self.currentViewCenter, translation);
    self.currentView.center = BL_CGPointAdd(self.currentViewCenter, self.panTranslationInCollectionView);
    self.collectionView.contentOffset = BL_CGPointAdd(contentOffset, translation);
}

#pragma mark - Actions

- (void)longPressGestureAction:(UILongPressGestureRecognizer*)gestureRecognizer
{
    switch(gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan: {
            // Get the current index path.
            NSIndexPath* currentIndexPath = [self.collectionView indexPathForItemAtPoint:[gestureRecognizer locationInView:self.collectionView]];
            
            // Check if editing.
            if (!self.editModeActive && currentIndexPath) {
                self.editModeActive = YES;
                [self invalidateLayout];
            }
            
            // Check if an item can be moved.
            if ([self.dataSource respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)] &&
                ![self.dataSource collectionView:self.collectionView canMoveItemAtIndexPath:currentIndexPath]) {
                return;
            }
            
            // Change the currently selected item.
            self.selectedItemIndexPath = currentIndexPath;
            
            // Notify that dragging will being.
            if ([self.delegate respondsToSelector:@selector(collectionView:layout:willBeginDraggingItemAtIndexPath:)]) {
                [self.delegate collectionView:self.collectionView layout:self willBeginDraggingItemAtIndexPath:self.selectedItemIndexPath];
            }
            
            // Get the cell to drag.
            UICollectionViewCell *collectionViewCell = [self.collectionView cellForItemAtIndexPath:self.selectedItemIndexPath];
            
            // Create a dragable view.
            self.currentView = [[UIView alloc] initWithFrame:collectionViewCell.frame];
            
            // Add a rasterized image of the cell in highlighted and regular states to the dragable view.
            collectionViewCell.highlighted = YES;
            UIImageView *highlightedImageView = [[UIImageView alloc] initWithImage:[collectionViewCell BL_rasterizedImage]];
            highlightedImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            highlightedImageView.alpha = 1.0f;
            
            collectionViewCell.highlighted = NO;
            UIImageView *imageView = [[UIImageView alloc] initWithImage:[collectionViewCell BL_rasterizedImage]];
            imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            imageView.alpha = 0.0f;
            
            [self.currentView addSubview:imageView];
            [self.currentView addSubview:highlightedImageView];
            [self.collectionView addSubview:self.currentView];
            
            self.currentViewCenter = self.currentView.center;
            
            __weak typeof(self) weakSelf = self;
            [UIView
             animateWithDuration:0.3
             delay:0.0
             options:UIViewAnimationOptionBeginFromCurrentState
             animations:^{
                 __strong typeof(self) strongSelf = weakSelf;
                 if (strongSelf) {
                     strongSelf.currentView.transform = CGAffineTransformMakeScale(1.1f, 1.1f);
                     highlightedImageView.alpha = 0.0f;
                     imageView.alpha = 1.0f;
                 }
             }
             completion:^(BOOL finished) {
                 __strong typeof(self) strongSelf = weakSelf;
                 if (strongSelf) {
                     [highlightedImageView removeFromSuperview];
                     
                     if ([strongSelf.delegate respondsToSelector:@selector(collectionView:layout:didBeginDraggingItemAtIndexPath:)]) {
                         [strongSelf.delegate collectionView:strongSelf.collectionView layout:strongSelf didBeginDraggingItemAtIndexPath:strongSelf.selectedItemIndexPath];
                     }
                 }
             }];
            
            [self invalidateLayout];
        } break;
        case UIGestureRecognizerStateEnded: {
            NSIndexPath *currentIndexPath = self.selectedItemIndexPath;
            
            if (currentIndexPath) {
                if ([self.delegate respondsToSelector:@selector(collectionView:layout:willEndDraggingItemAtIndexPath:)]) {
                    [self.delegate collectionView:self.collectionView layout:self willEndDraggingItemAtIndexPath:currentIndexPath];
                }
                
                self.selectedItemIndexPath = nil;
                self.currentViewCenter = CGPointZero;
                
                UICollectionViewLayoutAttributes *layoutAttributes = [self layoutAttributesForItemAtIndexPath:currentIndexPath];
                
                __weak typeof(self) weakSelf = self;
                [UIView
                 animateWithDuration:0.3
                 delay:0.0
                 options:UIViewAnimationOptionBeginFromCurrentState
                 animations:^{
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         strongSelf.currentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                         strongSelf.currentView.center = layoutAttributes.center;
                     }
                 }
                 completion:^(BOOL finished) {
                     __strong typeof(self) strongSelf = weakSelf;
                     if (strongSelf) {
                         [strongSelf.currentView removeFromSuperview];
                         strongSelf.currentView = nil;
                         [strongSelf invalidateLayout];
                         
                         if ([strongSelf.delegate respondsToSelector:@selector(collectionView:layout:didEndDraggingItemAtIndexPath:)]) {
                             [strongSelf.delegate collectionView:strongSelf.collectionView layout:strongSelf didEndDraggingItemAtIndexPath:currentIndexPath];
                         }
                     }
                 }];
            }
        } break;
            
        default: break;
    }
}

- (void)panGestureAction:(UIPanGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        case UIGestureRecognizerStateChanged: {
            self.panTranslationInCollectionView = [gestureRecognizer translationInView:self.collectionView];
            CGPoint viewCenter = self.currentView.center = BL_CGPointAdd(self.currentViewCenter, self.panTranslationInCollectionView);
            
            [self invalidateLayoutIfNecessary];
            
            switch (self.scrollDirection) {
                case UICollectionViewScrollDirectionVertical: {
                    if (viewCenter.y < (CGRectGetMinY(self.collectionView.bounds) + self.scrollingTriggerEdgeInsets.top)) {
                        [self setupScrollTimerInDirection:BLScrollingDirectionUp];
                    } else {
                        if (viewCenter.y > (CGRectGetMaxY(self.collectionView.bounds) - self.scrollingTriggerEdgeInsets.bottom)) {
                            [self setupScrollTimerInDirection:BLScrollingDirectionDown];
                        } else {
                            [self invalidatesScrollTimer];
                        }
                    }
                } break;
                case UICollectionViewScrollDirectionHorizontal: {
                    if (viewCenter.x < (CGRectGetMinX(self.collectionView.bounds) + self.scrollingTriggerEdgeInsets.left)) {
                        [self setupScrollTimerInDirection:BLScrollingDirectionLeft];
                    } else {
                        if (viewCenter.x > (CGRectGetMaxX(self.collectionView.bounds) - self.scrollingTriggerEdgeInsets.right)) {
                            [self setupScrollTimerInDirection:BLScrollingDirectionRight];
                        } else {
                            [self invalidatesScrollTimer];
                        }
                    }
                } break;
            }
        } break;
        case UIGestureRecognizerStateEnded: {
            [self invalidatesScrollTimer];
        } break;
        default: {
            // Do nothing...
        } break;
    }
}

- (void)tapGestureAction:(UITapGestureRecognizer*)gestureRecognizer
{
    if (gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (self.editModeActive) {
            self.editModeActive = NO;
            [self invalidateLayout];
            
        }
    }
}

#pragma mark - UICollectionViewLayout

- (BLSpringboardCollectionViewLayoutAttributes*)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BLSpringboardCollectionViewLayoutAttributes *attribs = (BLSpringboardCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    attribs.editModeActive = [self isEditModeActive];
    
    if (attribs.representedElementCategory == UICollectionElementCategoryCell) {
        [self applyLayoutAttributes:attribs];
    }
    
    return attribs;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArrayInRect = [super layoutAttributesForElementsInRect:rect];
    for (BLSpringboardCollectionViewLayoutAttributes *attribs in attributesArrayInRect) {
        attribs.editModeActive = [self isEditModeActive];
        
        if (attribs.representedElementCategory == UICollectionElementCategoryCell) {
            [self applyLayoutAttributes:attribs];
        }
    }
    
    return attributesArrayInRect;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return (self.selectedItemIndexPath != nil);
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]) {
        CGPoint pt = [touch locationInView:self.collectionView];
        NSIndexPath* indexPath = [self.collectionView indexPathForItemAtPoint:pt];
        return (indexPath == nil);
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if ([self.longPressGestureRecognizer isEqual:gestureRecognizer]) {
        return [self.panGestureRecognizer isEqual:otherGestureRecognizer];
    }
    
    if ([self.panGestureRecognizer isEqual:gestureRecognizer]) {
        return [self.longPressGestureRecognizer isEqual:otherGestureRecognizer];
    }
    
    return NO;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:BLCollectionViewKeyPath]) {
        if (self.collectionView != nil) {
            [self setupCollectionView];
        }
        else {
            [self invalidatesScrollTimer];
        }
    }
}

@end
