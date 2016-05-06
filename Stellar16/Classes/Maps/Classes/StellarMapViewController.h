//
//  StellarMapViewController.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import <MapKit/MapKit.h>

@class StellarLocation;

@interface StellarMapViewController : UIViewController <MKMapViewDelegate>

@property(strong, nonatomic) IBOutlet MKMapView *mapView;

- (void)loadMapWithLocation:(StellarLocation *)position ClearOtherAnnotations:(BOOL)clearAnnotations Type:(int)markerType Zoom:(BOOL)zoom;
- (void)loadMapWithLocation:(StellarLocation *)position ClearOtherAnnotations:(BOOL)clearAnnotations Type:(int)markerType MarkerImage:(NSString *)markerImage Zoom:(BOOL)zoom;
- (void)showAllAnnotations:(BOOL)showLocation;
- (void)showAllAnnotations:(BOOL)showLocation CenterOnLocation:(BOOL)center;
- (void)removeAllAnnotationsExceptGPS;

@end
