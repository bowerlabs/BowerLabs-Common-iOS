//
//  MKMapView+BowerLabsMapKit.h
//  BowerLabsMapKit
//
//  Created by Jeremy Bower on 2013-01-21.
//  Copyright (c) 2013 Bower Labs Inc. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MKMapView (BowerLabsMapKit)

- (MKCoordinateRegion)regionThatFitsAnnotationsWithMinimumRadius:(CLLocationDistance)minimumRadius;

@end