//
//  StellarRequest.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarRequest.h"
#import "StellarRequestManager.h"
#import "StellarRequestFileDetail.h"

@implementation StellarRequest

/**
 * Initialization method with the ID of the specific request being implemented by the subclass.
 */
- (id)initWithId:(int)_id
{
	self = [super init];
	if (self)
	{
		self._id = _id;
		self.processingResult = nil;
	}
	return self;
}


- (id)initWithId:(int)_id Type:(int)type
{
    self = [self initWithId:_id];
    if (self)
    {
        self.type = type;
    }
    return self;
}


/**
 * Method called by the subclass once it has finished setting the necessary request parameters. This method will created the webservice and build the request.
 */
- (void)createRequest
{
    if (_useStubs && _stubData != nil)
    {
		@try
		{
			[self processResponseData:[_stubData dataUsingEncoding:NSUTF8StringEncoding]];
			[self.delegate request:self successWithResult:_processingResult];
		}
		@catch (NSException *exception)
		{
            [_delegate request:self generalErrorWithResult:_processingResult];
		}
        return;
    }
    
    //Create URL and request.
    NSString* url = [StellarRequestUtils urlWithUrlParameters:self.urlString Parameters:self.urlParameters];
    NSMutableURLRequest *request;
    
    if (_files != nil)
    {
        request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:_requestMethod URLString:url parameters:_postDataValuesAndKeys constructingBodyWithBlock:^(id <AFMultipartFormData>formData)
        {
            for (StellarRequestFileDetail *fileDetail in _files)
            {
                [formData appendPartWithFileData:fileDetail.data name:fileDetail.name fileName:fileDetail.filename mimeType:fileDetail.mimeType];
            }
        }
        error:nil];
    }
    else
    {
        //Default to GET
        if (_requestMethod == nil)
        {
            _requestMethod = @"GET";
        }
        
        request = [[AFHTTPRequestSerializer serializer] requestWithMethod:_requestMethod URLString:url parameters:_postDataValuesAndKeys error:nil];
    }
    
    request.HTTPShouldHandleCookies = NO;
    
    //Add request headers.
    if (_requestHeaders != nil)
    {
        request.allHTTPHeaderFields = [NSDictionary dictionaryWithDictionary:_requestHeaders];
    }
    
    AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [requestOperation setUploadProgressBlock:_uploadProgressBlock];
    
    [requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        self.isBusy = NO;
         
        //Return if no delegate.
        if (_delegate == nil)
        {
            return;
        }
         
        //General error if no response data.
        if (responseObject == nil)
        {
            [self.delegate request:self generalErrorWithResult:self.processingResult];
            return;
        }
         
        //Process response data.
        BOOL processingSuccess = [self processResponseObject:responseObject];
        int statusCode = operation.response.statusCode;
        NSString *statusMessage = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
         
        if (statusCode == 200)
        {
            if (processingSuccess)
            {
                [self.delegate request:self successWithResult:_processingResult];
            }
            else
            {
                [self.delegate request:self generalErrorWithResult:_processingResult];
            }
        }
        else
        {
            [self.delegate request:self httpErrorWithResult:_processingResult code:statusCode message:statusMessage];
        }
    }
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        self.isBusy = NO;
         
        if (self.request.isCancelled)
        {
            return;
        }
         
        if (operation.responseObject == nil)
        {
            [self.delegate request:self connectionErrorWithResult:error];
            return;
        }
         
        //Process response data.
        [self processResponseObject:operation.responseObject];
        int statusCode = operation.response.statusCode;
        NSString *statusMessage = [NSHTTPURLResponse localizedStringForStatusCode:statusCode];
         
        [self.delegate request:self httpErrorWithResult:_processingResult code:statusCode message:statusMessage];
    }];
    
    self.request = requestOperation;
    [self queueRequest];
}


/**
 * Queue this request's operation for execution.
 */
- (void)queueRequest
{
	StellarRequestManager *manager = (StellarRequestManager *) [StellarRequestManager sharedManager];
    [manager queueRequest:self];
}


/**
 * Process response data
 */
- (BOOL)processResponseObject:(id)responseObject
{
    //Process response data.
    BOOL processingSuccess;
    @try
    {
        //Call to "protected" method implemented by subclass.
        processingSuccess = [self processResponseData:responseObject];
    }
    @catch (NSException *exception)
    {
        processingSuccess = NO;
    }
    return processingSuccess;
}


/**
 * Override this method to process the response of specific request being implemented by this subclass.
 */
- (BOOL)processResponseData:(NSData *)responseData
{
    self.processingResult = responseData;
	return YES;
}

@end
