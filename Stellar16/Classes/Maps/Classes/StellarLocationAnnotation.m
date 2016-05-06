//
//  StellarLocationAnnotation.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarLocationAnnotation.h"
#import "StellarLocation.h"

@implementation StellarLocationAnnotation

- (id)initWithLocation:(StellarLocation *)newLocation Type:(int)newType
{
    self = [super init];
    if (self)
    {
        self.type = newType;
        self.location = newLocation;
        self.title = self.location.address;
        
        _coordinate.latitude = self.location.latitude;
        _coordinate.longitude = self.location.longitude;
    }
    return self;
}

@end
