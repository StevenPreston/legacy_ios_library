//
//  StellarLocation.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarLocation.h"

@implementation StellarLocation

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    if (self)
    {
        self._id = [coder decodeObjectForKey:@"id"];
		self.address = [coder decodeObjectForKey:@"location"];
		self.longitude = [coder decodeFloatForKey:@"longitude"];
		self.latitude= [coder decodeFloatForKey:@"latitude"];
    }
	return self;
}


- (void)encodeWithCoder: (NSCoder *)coder
{
    [coder encodeObject:__id forKey: @"id"];
	[coder encodeObject:_address forKey:@"location"];
	[coder encodeFloat:_longitude forKey:@"longitude"];
	[coder encodeFloat:_latitude forKey:@"latitude"];
}


- (id)copy
{
    StellarLocation *newLocation = [[StellarLocation alloc] init];
    newLocation._id = [__id copy];
    newLocation.address = [_address copy];
    newLocation.longitude = _longitude;
    newLocation.latitude = _latitude;
    return newLocation;
}

@end
