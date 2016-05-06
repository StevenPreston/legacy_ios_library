//
//  StellarRequest.h
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarRequestDelegate.h"
#import "StellarRequestUtils.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPSessionManager.h"

@interface StellarRequest : NSObject

@property (nonatomic, strong) AFHTTPRequestOperation *request;
@property (nonatomic, weak) id <NSObject, StellarRequestDelegate> delegate;
@property (nonatomic, assign) BOOL isBusy;
@property (nonatomic, assign) BOOL useStubs;
@property (nonatomic, copy) NSString *stubData;
@property (nonatomic, assign) int _id;
@property (nonatomic, assign) int type;
@property (nonatomic, strong) id processingResult;
@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *requestMethod;
@property (nonatomic, copy) NSMutableDictionary *postDataValuesAndKeys;
@property (nonatomic, copy) NSArray *files;
@property (nonatomic, copy) NSString *contentType;
@property (nonatomic, copy) NSDictionary *requestHeaders;
@property (nonatomic, copy) NSDictionary *urlParameters;
@property (nonatomic, strong) void (^uploadProgressBlock)(NSUInteger bytesWritten, NSInteger totalBytesWritten, NSInteger totalBytesExpectedToWrite);

- (id)initWithId:(int)newId;
- (id)initWithId:(int)_id Type:(int)type;
- (void)createRequest;
- (void)queueRequest;
- (BOOL)processResponseObject:(id)responseObject;
- (BOOL)processResponseData:(NSData *)responseData;

@end
