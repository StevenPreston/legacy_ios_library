//
//  StellarMapUtils.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface StellarMapUtils: NSObject

+ (MKCoordinateRegion)getRegionOfAnnotations:(NSArray *)annotations ForMapView:(MKMapView *)mapView;
+ (MKCoordinateRegion)getRegionOfAnnotations:(NSArray *)annotations ForMapView:(MKMapView *)mapView CenterOnLocation:(BOOL)shouldCenter;

@end
