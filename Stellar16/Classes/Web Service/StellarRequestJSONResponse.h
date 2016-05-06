//
//  StellarRequestJSONResponse.h
//  Hoppit
//
//  Created by Steven Preston on 3/7/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "StellarRequest.h"

@interface StellarRequestJSONResponse : StellarRequest

- (BOOL)processResponseData:(NSData *)responseData;
- (BOOL)processResponseDictionary:(NSDictionary *)responseDictionary;

@end
