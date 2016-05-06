//
//  StellarStyleUtils.m
//  Hoppit
//
//  Created by Steven Preston on 7/19/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "StellarStyleUtils.h"

@implementation StellarStyleUtils

#pragma mark - Shadow Utilities

+ (void)addShadowToView:(UIView *)view Offset:(float)offset Opacity:(float)opacity Radius:(float)radius
{
    CALayer *layer = view.layer;
    layer.shadowOffset = CGSizeMake(0, offset);
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = opacity;
    layer.shadowRadius = radius;
    
    CGPathRef shadowPath = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
    layer.shadowPath = shadowPath;
}


+ (void)addShadowToView:(UIView *)view
{
    [StellarStyleUtils addShadowToView:view Offset:1.0f Opacity:0.6f Radius:1.0f];
    view.layer.shadowColor = [UIColor blackColor].CGColor;
}


+ (void)removeShadowFromView:(UIView *)view
{
    CALayer *layer = view.layer;
    layer.shadowOffset = CGSizeMake(0, 0);
    layer.shadowOpacity = 0;
}

@end
