//
//  StellarRequestManager.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2010 Stellar16. All rights reserved.
//

#import "StellarRequestManager.h"
#import "StellarRequest.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@implementation StellarRequestManager

/**
 * Static method to implement this class as a singleton.
 */
+ (StellarRequestManager *)sharedManager
{
    static StellarRequestManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,
    ^{
        _sharedManager = [[self alloc] init];
    });

    return _sharedManager;
}


/**
 * Initialization method.
 */
- (id)init
{
	if (self = [super init])
    {
		self.queues = [[NSMutableDictionary alloc] initWithCapacity:0];
        
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
	}
	return self;
}


/**
 * Queues the request for execution.
 */
- (void)queueRequest:(StellarRequest *)request
{
	request.isBusy = YES;
    
    NSMutableDictionary *queuesForId = [_queues objectForKey:[NSNumber numberWithInt:request._id]];
    if (queuesForId == nil)
    {
        queuesForId = [NSMutableDictionary dictionaryWithCapacity:1];
        [_queues setObject:queuesForId forKey:[NSNumber numberWithInt:request._id]];
    }
    
	NSOperationQueue *queue = [queuesForId objectForKey:[NSNumber numberWithInt:request.type]];
    if (queue == nil)
    {
        queue = [[NSOperationQueue alloc] init];
        [queuesForId setObject:queue forKey:[NSNumber numberWithInt:request.type]];
    }
    
    [queue addOperation:request.request];
}


/**
 * Cancel all requests with the request ID.
 */
- (void)cancelRequestsWithId:(int)_id
{
    NSMutableDictionary *queuesForId = [_queues objectForKey:[NSNumber numberWithInt:_id]];
    for (NSOperationQueue *queue in queuesForId.allValues)
    {
        [queue cancelAllOperations];
    }
}


/**
 * Cancel all requests with the request ID and type.
 */
- (void)cancelRequestsWithId:(int)_id Type:(int)type
{
    NSMutableDictionary *queuesForId = [_queues objectForKey:[NSNumber numberWithInt:_id]];
    NSOperationQueue *queue = [queuesForId objectForKey:[NSNumber numberWithInt:type]];
    if (queue != nil)
    {
        [queue cancelAllOperations];
    }
}


/**
 * Cancel all requests.
 */
- (void)cancelAllRequests
{
    for (NSMutableDictionary *queuesForId in _queues.allValues)
    {
        for (NSOperationQueue *queue in queuesForId.allValues)
        {
            [queue cancelAllOperations];
        }
    }
}

@end
