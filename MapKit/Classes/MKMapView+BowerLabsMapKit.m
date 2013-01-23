//
//  MKMapView+BowerLabsMapKit.m
//  BowerLabsMapKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import "MKMapView+BowerLabsMapKit.h"

#import "NSArray+BowerLabsFoundation.h"
#import "NSMutableArray+BowerLabsFoundation.h"

@implementation MKMapView (BowerLabsMapKit)

- (MKCoordinateRegion)regionThatFitsAnnotationsWithMinimumRadius:(CLLocationDistance)minimumRadius
{
    if (self.annotations.count == 0) {
        return [self region];
    }
    else if (self.annotations.count == 1) {
        id<MKAnnotation> firstAnnotation = [self.annotations firstObject];
        
        return [self regionThatFits:MKCoordinateRegionMakeWithDistance([firstAnnotation coordinate], 
                                                                       minimumRadius, 
                                                                       minimumRadius)];
    }
    else {
        CLLocationCoordinate2D topLeftCoord; 
        topLeftCoord.latitude = -90; 
        topLeftCoord.longitude = 180; 
        
        CLLocationCoordinate2D bottomRightCoord; 
        bottomRightCoord.latitude = 90; 
        bottomRightCoord.longitude = -180; 
        
        for (id<MKAnnotation> annotation in self.annotations) { 
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude); 
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude); 
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude); 
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude); 
        } 
        
        MKCoordinateRegion region; 
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.5; 
        region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.5;      
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * 1.1; 
        
        // Add a little extra space on the sides 
        region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude) * 1.1; 
        
        // Add a little extra space on the sides 
        return [self regionThatFits:region];
    }
}

@end