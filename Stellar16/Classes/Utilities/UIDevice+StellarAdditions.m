//
//  UIDevice+StellarAdditions.m
//  Hoppit
//
//  Created by Steven Preston on 9/23/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import "UIDevice+StellarAdditions.h"

@implementation UIDevice (StellarAdditions)

+ (BOOL)isIOS4
{
    return [UIDevice.currentDevice.systemVersion hasPrefix:@"4"];
}


+ (BOOL)isIOS6OrLater
{
    return UIDevice.currentDevice.systemVersion.floatValue >= 6;
}


+ (BOOL)isIPhone5
{
    return UIScreen.mainScreen.bounds.size.height == 568;
}

@end
