//
//  StellarLocationAnnotationView.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarLocationAnnotationView.h"
#import "StellarLocationAnnotation.h"
#import "StellarLocation.h"

@implementation StellarLocationAnnotationView

- (void)setAnnotation:(id<MKAnnotation>)annotation
{
    [super setAnnotation:annotation];
    
    if (![annotation isKindOfClass:[StellarLocationAnnotation class]])
    {
        return;
    }
    
    StellarLocationAnnotation *locationAnnotation = (StellarLocationAnnotation *)annotation;
    
    for (UIView *view in [self subviews])
    {
        [view removeFromSuperview];
    }
    
    width = DIMENSION_IPHONE;
	height = DIMENSION_IPHONE;
	
	NSString *deviceType = [UIDevice currentDevice].model;
    
	if ([[deviceType lowercaseString] rangeOfString:@"iphone"].location == NSNotFound && [[deviceType lowercaseString] rangeOfString:@"ipod"].location == NSNotFound)
	{
        width = DIMENSION_IPAD;
        height = DIMENSION_IPAD;
	}
    
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(0, 0, width, height);
    
    if (locationAnnotation.type == StellarLocationAnnotationTypeCustom)
    {
        UIImage *image = locationAnnotation.markerImage != nil ? [UIImage imageNamed:locationAnnotation.markerImage] : [UIImage imageNamed:@"icon_location.png"];
        
        self.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        self.imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_imageView];
        
        self.rightCalloutAccessoryView = nil;
        self.canShowCallout = YES;
    }
}

@end
