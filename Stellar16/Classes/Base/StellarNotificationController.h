//
//  StellarNotificationController.h
//  Hoppit
//
//  Created by Steven Preston on 7/6/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#define NOTIFICATION_RESULT @"NOTIFICATION_RESULT"

@protocol NotificationObserver

- (void)notificationReceived:(NSNotification *)notification;

@end

@interface StellarNotificationController : NSObject

+ (void)registerForNotifications:(id <NotificationObserver>)observer Name:(NSString *)name;
+ (void)deregisterForNotifications:(id <NotificationObserver>)observer;

@end
