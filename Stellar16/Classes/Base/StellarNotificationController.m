//
//  StellarNotificationController.m
//  Hoppit
//
//  Created by Steven Preston on 7/6/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import "StellarNotificationController.h"

@implementation StellarNotificationController

+ (void)registerForNotifications:(id<NotificationObserver>)observer Name:(NSString *)name
{
	[[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(notificationReceived:) name:name object:nil];
}


+ (void)deregisterForNotifications:(id<NotificationObserver>)observer
{
	[[NSNotificationCenter defaultCenter] removeObserver:observer];
}

@end
