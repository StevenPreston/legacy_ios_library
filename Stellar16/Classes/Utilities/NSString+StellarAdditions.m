//
//  NSString+StellarAdditions.m
//  Hoppit
//
//  Created by Steven Preston on 8/7/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import "NSString+StellarAdditions.h"

@implementation NSString (StellarAdditions)

- (NSString *)stringByUrlEncodingUsingEncoding:(NSStringEncoding)encoding
{
    NSMutableString * output = [NSMutableString string];
    const unsigned char * source = (const unsigned char *)[self UTF8String];
    int sourceLen = strlen((const char *)source);
    for (int i = 0; i < sourceLen; ++i) {
        const unsigned char thisChar = source[i];
        if (thisChar == ' '){
            [output appendString:@"+"];
        } else if (thisChar == '.' || thisChar == '-' || thisChar == '_' || thisChar == '~' ||
                   (thisChar >= 'a' && thisChar <= 'z') ||
                   (thisChar >= 'A' && thisChar <= 'Z') ||
                   (thisChar >= '0' && thisChar <= '9')) {
            [output appendFormat:@"%c", thisChar];
        } else {
            [output appendFormat:@"%%%02X", thisChar];
        }
    }
    return output;
}

@end
