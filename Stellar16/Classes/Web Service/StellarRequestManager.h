//
//  StellarRequestManager.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2010 Stellar16. All rights reserved.
//

@class StellarRequest;

@interface StellarRequestManager : NSObject

@property (nonatomic, strong) NSMutableDictionary *queues;

+ (StellarRequestManager *)sharedManager;
- (void)queueRequest:(StellarRequest *)request;
- (void)cancelRequestsWithId:(int)_id;
- (void)cancelRequestsWithId:(int)_id Type:(int)type;
- (void)cancelAllRequests;

@end
