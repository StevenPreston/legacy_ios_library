//
//  StellarLocationAnnotation.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import <MapKit/MapKit.h>

@class StellarLocation;

typedef enum
{
    StellarLocationAnnotationTypeGreenPin = 1,
    StellarLocationAnnotationTypeRedPin = 2,
    StellarLocationAnnotationTypeCustom = 3,
} StellarLocationAnnotationType;

@interface StellarLocationAnnotation : NSObject <MKAnnotation>

@property (assign, nonatomic) int type;
@property (strong, nonatomic) NSString *markerImage;
@property (strong, nonatomic) StellarLocation *location;
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;

- (id)initWithLocation:(StellarLocation *)newLocation Type:(int)newType;

@end
