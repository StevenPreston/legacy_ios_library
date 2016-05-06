//
//  StellarRequestJSONResponse.m
//  Hoppit
//
//  Created by Steven Preston on 3/7/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "StellarRequestJSONResponse.h"

@implementation StellarRequestJSONResponse

- (BOOL)processResponseData:(NSData *)responseData
{
	NSMutableDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
	if (responseDictionary == nil)
	{
		return NO;
	}
    else
    {
        return [self processResponseDictionary:responseDictionary];
    }
}

                
- (BOOL)processResponseDictionary:(NSDictionary *)responseDictionary;
{
    return YES;
}

@end
