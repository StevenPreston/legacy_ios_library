//
//  StellarLocationAnnotationView.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import <MapKit/MapKit.h>

#define DIMENSION_IPHONE 32
#define DIMENSION_IPAD 50
#define BORDER 2

@class StellarLocationAnnotation;

@interface StellarLocationAnnotationView : MKAnnotationView
{
    int width;
    int height;
}

@property(strong, nonatomic) UIImageView *imageView;

@end
