//
//  StellarRequestDelegate.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

@class StellarRequest;

@protocol StellarRequestDelegate

- (void)request:(StellarRequest *)request successWithResult:(id)result;
- (void)request:(StellarRequest *)request connectionErrorWithResult:(id)result;
- (void)request:(StellarRequest *)request generalErrorWithResult:(id)result;
- (void)request:(StellarRequest *)request httpErrorWithResult:(id)result code:(int)code message:(NSString *)message;

@end
