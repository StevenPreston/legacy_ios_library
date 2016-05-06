//
//  StellarRequestUtils.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

@interface StellarRequestUtils : NSObject

+ (id)validateJSONResponseValue:(id)responseValue;
+ (NSString *)urlWithUrlParameters:(NSString *)url Parameters:(NSDictionary *)urlParameters;
+ (NSString *)stringFromStub:(NSString *)stubName; //returns a string from a .stub app bundle resource

@end
