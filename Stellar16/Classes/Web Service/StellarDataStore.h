//
//  StellarDataStore.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarRequestDelegate.h"
#import "StellarNotificationController.h"

@class StellarRequest;

#define NOTIFICATION_REQUEST @"NOTIFICATION_REQUEST"
#define NOTIFICATION_REQUEST_RESULT_SUCCESS 0
#define NOTIFICATION_REQUEST_RESULT_CONNECTION_ERROR 1
#define NOTIFICATION_REQUEST_RESULT_GENERAL_ERROR 2
#define NOTIFICATION_REQUEST_RESULT_HTTP_ERROR 3

@interface StellarDataStore : NSObject <StellarRequestDelegate>

+ (StellarDataStore *)sharedDataStore;
- (void)cancelRequestsWithId:(int)_id;
- (void)cancelRequestsWithId:(int)_id Type:(int)type;
- (void)cancelAllRequests;
- (void)notifyWithRequest:(StellarRequest *)request Result:(int)result;

@end
