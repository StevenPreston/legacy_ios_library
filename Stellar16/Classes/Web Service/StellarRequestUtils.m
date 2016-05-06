//
//  StellarRequestUtils.m
//  Stellar16
//
//  Created by Steven Preston on 2012/05/01.
//  Copyright 2012 Stellar16. All rights reserved.
//

#import "StellarRequestUtils.h"

@implementation StellarRequestUtils

+ (id)validateJSONResponseValue:(id)responseValue
{
    if (responseValue == nil || [responseValue isEqual:[NSNull null]])
    {
        return nil;
    }
    else
    {
        return responseValue;
    }
}


+ (NSString *)urlWithUrlParameters:(NSString *)url Parameters:(NSDictionary *)urlParameters;
{
    NSString *urlWithParameters = [NSString stringWithString:url];
    
    // check to see if url parameters have been specified
    if (urlParameters != nil)
    {
        NSString *paramString = nil;
        
        // Work-around for URLs that may use a parameter to indicate an "action" instead of a path in the URL itself.
        BOOL hasQuestionMark = NO;
        NSRange textRange;
        textRange = [urlWithParameters rangeOfString:@"?"];
        
        if(textRange.location != NSNotFound)
        {
            hasQuestionMark = YES;
        }			
        
        for (int i = 0; i < [[urlParameters allKeys] count]; i++)
        {
            if (i == 0)
            {
                if (hasQuestionMark == YES)
                {
                    paramString = [NSString stringWithFormat:@"&%@=%@",  
                                   [[urlParameters allKeys] objectAtIndex:i], 
                                   [urlParameters objectForKey:[[urlParameters allKeys] objectAtIndex:i]]];
                }
                else
                {
                    paramString = [NSString stringWithFormat:@"?%@=%@",  
                                   [[urlParameters allKeys] objectAtIndex:i], 
                                   [urlParameters objectForKey:[[urlParameters allKeys] objectAtIndex:i]]];
                }  
            }
            else
            {
                paramString = [NSString stringWithFormat:@"%@&%@=%@", paramString,  
                               [[urlParameters allKeys] objectAtIndex:i], 
                               [urlParameters objectForKey:[[urlParameters allKeys] objectAtIndex:i]]];
            }
        }
        urlWithParameters = [url stringByAppendingString:paramString];
        urlWithParameters = [urlWithParameters stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
    return urlWithParameters;
}


+ (NSString *)stringFromStub:(NSString *)stubName
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource:stubName ofType:@"stub"];
	return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
}

@end
