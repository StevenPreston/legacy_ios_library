//
//  StellarMapUtils.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarMapUtils.h"
#import "StellarLocationAnnotation.h"

@implementation StellarMapUtils

+ (MKCoordinateRegion)getRegionOfAnnotations:(NSArray *)annotations ForMapView:(MKMapView *)mapView
{
    CLLocationCoordinate2D workingCoordinate;		
	CLLocationCoordinate2D southWest;
	CLLocationCoordinate2D northEast;
	MKCoordinateRegion region;
    
    int count = 0;
    for (int i = 0; i < [annotations count]; i++)
    {
        id<MKAnnotation> tempAnnotation = [annotations objectAtIndex: i];
        
        if ([tempAnnotation isKindOfClass:[StellarLocationAnnotation class]])
        {
            StellarLocationAnnotation *annotation = tempAnnotation;
            workingCoordinate.longitude = annotation.coordinate.longitude;
            workingCoordinate.latitude = annotation.coordinate.latitude;
            
        }
        else if ([tempAnnotation isEqual:mapView.userLocation])
        {
            MKUserLocation *annotation = tempAnnotation;
            workingCoordinate.longitude = annotation.coordinate.longitude;
            workingCoordinate.latitude = annotation.coordinate.latitude;
        }
        
        if (count == 0)
        {
            southWest = workingCoordinate;
            northEast = workingCoordinate;
        }
        count++;
        
        southWest.latitude = MIN(southWest.latitude, workingCoordinate.latitude);
        southWest.longitude = MIN(southWest.longitude, workingCoordinate.longitude);
        
        northEast.latitude = MAX(northEast.latitude, workingCoordinate.latitude);
        northEast.longitude = MAX(northEast.longitude, workingCoordinate.longitude);
        
        CLLocation *locSouthWest = [[CLLocation alloc] initWithLatitude:southWest.latitude longitude:southWest.longitude];
        CLLocation *locNorthEast = [[CLLocation alloc] initWithLatitude:northEast.latitude longitude:northEast.longitude];
        
        CLLocationDistance meters = [locSouthWest distanceFromLocation:locNorthEast];
        
        region.center.latitude = (southWest.latitude + northEast.latitude) / 2.0;
        region.center.longitude = (southWest.longitude + northEast.longitude) / 2.0;
        region.span.latitudeDelta = meters / 111319.5;
        region.span.longitudeDelta = 0.0;        
    }

    return region;
}


+ (MKCoordinateRegion)getRegionOfAnnotations:(NSArray *)annotations ForMapView:(MKMapView *)mapView CenterOnLocation:(BOOL)shouldCenter
{
    if (!shouldCenter)
    {
        return [StellarMapUtils getRegionOfAnnotations:annotations ForMapView:mapView];
    }
    
    MKCoordinateRegion region;
    CLLocationCoordinate2D workingCoordinate;		
    CLLocationCoordinate2D userLocation;
    CLLocationDistance maxDistance = 0;
    BOOL locationFound = NO;
    
    //Find user's location.
    for (int i = 0; i < [annotations count]; i++)
    {
        id <MKAnnotation> tempAnnotation = [annotations objectAtIndex: i];
        
        if ([tempAnnotation isEqual: mapView.userLocation])
        {
            MKUserLocation *annotation = tempAnnotation;
            userLocation.longitude = annotation.coordinate.longitude;
            userLocation.latitude = annotation.coordinate.latitude;
            locationFound = YES;
        }
    }
    
    //If no user location.
    if(!locationFound)
    {
        return [StellarMapUtils getRegionOfAnnotations:annotations ForMapView:mapView];
    }

    //Find furthest distance.
    for (int i = 0; i < [annotations count]; i++)
    {
        id<MKAnnotation> tempAnnotation = [annotations objectAtIndex: i];
        
        if ([tempAnnotation isKindOfClass:[StellarLocationAnnotation class]])
        {
            StellarLocationAnnotation *annotation = tempAnnotation;
            workingCoordinate.longitude = annotation.coordinate.longitude;
            workingCoordinate.latitude = annotation.coordinate.latitude;
            
            CLLocation *start = [[CLLocation alloc] initWithLatitude:userLocation.latitude longitude:userLocation.longitude];
            CLLocation *end = [[CLLocation alloc] initWithLatitude:workingCoordinate.latitude longitude:workingCoordinate.longitude];
            
            CLLocationDistance distance =  [start distanceFromLocation:end];
            maxDistance = MAX(distance,maxDistance);
        }
    }
    
    //Center on user's location.
    region.center.latitude = userLocation.latitude;
    region.center.longitude = userLocation.longitude;

    //Set span to twice the farthest distance.
    region.span.latitudeDelta = maxDistance * 2 / 111319.5;
    region.span.longitudeDelta = 0.0;
    
    return region;
}

@end
