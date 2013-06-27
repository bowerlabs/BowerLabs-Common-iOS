//
//  BLSpringboardCollectionViewCell.m
//  BowerLabsUIKit
//
//  Created by Jeremy Bower on 2013-06-27.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "BLSpringboardCollectionViewCell.h"

#import "BLSpringboardCollectionViewLayoutAttributes.h"

@implementation BLSpringboardCollectionViewCell

- (void)applyLayoutAttributes:(BLSpringboardCollectionViewLayoutAttributes*)layoutAttributes
{
    if (!layoutAttributes.isEditModeActive) {
        self.deleteButton.layer.opacity = 0.0;
        [self stopQuivering];
    }
    else {
        self.deleteButton.layer.opacity = 1.0;
        [self startQuivering];
    }
}

- (void)startQuivering
{
    CABasicAnimation *quiverAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    float startAngle = (-2) * M_PI/180.0;
    float stopAngle = -startAngle;
    quiverAnim.fromValue = [NSNumber numberWithFloat:startAngle];
    quiverAnim.toValue = [NSNumber numberWithFloat:3 * stopAngle];
    quiverAnim.autoreverses = YES;
    quiverAnim.duration = 0.2;
    quiverAnim.repeatCount = HUGE_VALF;
    float timeOffset = (float)(arc4random() % 100)/100 - 0.50;
    quiverAnim.timeOffset = timeOffset;
    CALayer *layer = self.layer;
    [layer addAnimation:quiverAnim forKey:@"quivering"];
}

- (void)stopQuivering
{
    CALayer *layer = self.layer;
    [layer removeAnimationForKey:@"quivering"];
}

@end
