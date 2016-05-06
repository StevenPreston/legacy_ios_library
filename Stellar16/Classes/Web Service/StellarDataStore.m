//
//  StellarDataStore.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarDataStore.h"
#import "StellarRequestManager.h"

@implementation StellarDataStore

/**
 * Static method to implement this class as a singleton.
 */
+ (StellarDataStore *)sharedDataStore
{
    static StellarDataStore *_sharedDataStore = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,
    ^{
        _sharedDataStore = [[self alloc] init];
    });
    
    return _sharedDataStore;
}


#pragma mark - Cancel Methods

- (void)cancelRequestsWithId:(int)_id
{
    StellarRequestManager *requestManager  = [StellarRequestManager sharedManager];
    [requestManager cancelRequestsWithId:_id];
}


- (void)cancelRequestsWithId:(int)_id Type:(int)type
{
    StellarRequestManager *requestManager  = [StellarRequestManager sharedManager];
    [requestManager cancelRequestsWithId:_id Type:type];
}


- (void)cancelAllRequests
{
    StellarRequestManager *requestManager  = [StellarRequestManager sharedManager];
    [requestManager cancelAllRequests];
}


#pragma mark - StellarRequestMethods

- (void)request:(StellarRequest *)request successWithResult:(id)result {}
- (void)request:(StellarRequest *)request connectionErrorWithResult:(id)result {}
- (void)request:(StellarRequest *)request generalErrorWithResult:(id)result {}
- (void)request:(StellarRequest *)request httpErrorWithResult:(id)result code:(int)code message:(NSString *)message {}


#pragma mark - Request Notification Methods

- (void)notifyWithRequest:(StellarRequest *)request Result:(int)result;
{
	NSNumber *requestResult = [NSNumber numberWithInt:result];
	NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
							  request, NOTIFICATION_REQUEST, 
							  requestResult, NOTIFICATION_RESULT,
                              nil];
	
	[[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_REQUEST object:self userInfo:userInfo];
}

@end
