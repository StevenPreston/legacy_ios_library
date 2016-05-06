//
//  StellarStyleUtils.h
//  Hoppit
//
//  Created by Steven Preston on 7/19/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

@interface StellarStyleUtils : NSObject

//
// Style utilities to enable consistant styles across multiple items.
//
+ (void)addShadowToView:(UIView *)view Offset:(float)offset Opacity:(float)opacity Radius:(float)radius;
+ (void)addShadowToView:(UIView *)view;
+ (void)removeShadowFromView:(UIView *)view;

@end
