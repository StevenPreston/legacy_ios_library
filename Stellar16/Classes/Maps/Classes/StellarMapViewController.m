//
//  StellarMapViewController.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>  
#import "StellarMapViewController.h"
#import "StellarConversionUtils.h"
#import "StellarMapUtils.h"
#import "StellarLocation.h"
#import "StellarLocationAnnotation.h"
#import "StellarLocationAnnotationView.h"

@implementation StellarMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	    
    //Start looking for the user's location immediately so its available when we need it.
    _mapView.showsUserLocation = YES;
}


#pragma mark - MKMapViewDelegate Methods

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation
{
	if ([annotation isKindOfClass:[MKUserLocation class]])
	{
		return nil;
	}
	
	MKAnnotationView *annotationView = nil;
	
	StellarLocationAnnotation *locationAnnotation = (StellarLocationAnnotation *)annotation;
	
    if ((locationAnnotation.type == StellarLocationAnnotationTypeGreenPin) || (locationAnnotation.type == StellarLocationAnnotationTypeRedPin))
	{
        static NSString* identifier = @"PinAnnotationView";
        
		MKPinAnnotationView *pinAnnotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (pinAnnotationView == nil)
        {
            pinAnnotationView = [[MKPinAnnotationView alloc] initWithAnnotation:locationAnnotation reuseIdentifier:identifier];
        }
        pinAnnotationView.pinColor = locationAnnotation.type == StellarLocationAnnotationTypeGreenPin ? MKPinAnnotationColorGreen : MKPinAnnotationColorRed;
        pinAnnotationView.canShowCallout = YES;
        
        annotationView = pinAnnotationView;
	}
    else
    {
        static NSString* identifier = @"LocationAnnotationView";
        
        StellarLocationAnnotationView *locationAnnotationView = (StellarLocationAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        
        if (locationAnnotationView == nil)
        {
            locationAnnotationView = [[StellarLocationAnnotationView alloc] initWithAnnotation:locationAnnotation reuseIdentifier:identifier];
        }
        else
        {
            [locationAnnotationView setAnnotation:locationAnnotation];
        }
        
        annotationView = locationAnnotationView;
    }
	
	return annotationView;
}


#pragma mark - Load Annotations methods

- (void)loadMapWithLocation:(StellarLocation *)location ClearOtherAnnotations:(BOOL)clearAnnotations Type:(int)markerType MarkerImage:(NSString *)markerImage Zoom:(BOOL)zoom
{    
	if (clearAnnotations)
	{
		[self removeAllAnnotationsExceptGPS];
	}
	
    StellarLocationAnnotation *annotation = [[StellarLocationAnnotation alloc] initWithLocation:location Type:markerType];
      
    [_mapView addAnnotation:annotation];

	if (zoom)
	{
        [self showAllAnnotations: NO];
	}
}


- (void)loadMapWithLocation:(StellarLocation *)location ClearOtherAnnotations:(BOOL)clearAnnotations Type:(int)markerType Zoom:(BOOL)zoom
{
    [self loadMapWithLocation:location ClearOtherAnnotations:clearAnnotations Type:markerType MarkerImage:nil Zoom:zoom];
}


- (void)showAllAnnotations:(BOOL)showLocation
{
    [self showAllAnnotations:showLocation CenterOnLocation:NO];
}


- (void)showAllAnnotations:(BOOL)showLocation CenterOnLocation:(BOOL)center
{    
	NSMutableArray *annotations = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (id<MKAnnotation> annotation in [_mapView annotations])
    {
        if ([annotation isEqual:_mapView.userLocation] && showLocation)
        {
            [annotations addObject:annotation];
        }
        else if (![annotation isEqual:_mapView.userLocation])
        {
            [annotations addObject:annotation];
        }
    }
    
	MKCoordinateRegion region = [StellarMapUtils getRegionOfAnnotations:annotations ForMapView:_mapView CenterOnLocation:center];
	
    //TODO: Figure out this exception
    @try
    {
        [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    }
    @catch (NSException *exception)
    {
    }
    @finally
    {
    }
}


- (void)removeAllAnnotationsExceptGPS
{
	NSArray *annotations = [_mapView annotations];
	NSMutableArray *annotationsRemove = [[NSMutableArray alloc] init];
	
	for (int i = [annotations count] - 1; i >= 0; i--)
	{
		id<MKAnnotation> annotation = [annotations objectAtIndex:i];
		
        if (annotation != _mapView.userLocation)
		{
			[annotationsRemove addObject:annotation];
		}
	}
	[_mapView removeAnnotations:annotationsRemove];
}

@end
