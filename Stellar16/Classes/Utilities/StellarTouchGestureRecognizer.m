//
//  StellarTouchGestureRecognizer.m
//  Hoppit
//
//  Created by Steven Preston on 9/24/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import "StellarTouchGestureRecognizer.h"

@implementation StellarTouchGestureRecognizer

- (id)init
{
    self = [super init];
    if (self)
    {
        self.cancelsTouchesInView = NO;
        self.delegate = self;
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchGestureRecognizerDelegate != nil && [_touchGestureRecognizerDelegate respondsToSelector:@selector(touchGestureRecognizer:touchesBegan:withEvent:)])
    {
        [_touchGestureRecognizerDelegate touchGestureRecognizer:self touchesBegan:touches withEvent:event];
    }
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchGestureRecognizerDelegate != nil && [_touchGestureRecognizerDelegate respondsToSelector:@selector(touchGestureRecognizer:touchesEnded:withEvent:)])
    {
        [_touchGestureRecognizerDelegate touchGestureRecognizer:self touchesEnded:touches withEvent:event];
    }
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_touchGestureRecognizerDelegate != nil && [_touchGestureRecognizerDelegate respondsToSelector:@selector(touchGestureRecognizer:touchesMoved:withEvent:)])
    {
        [_touchGestureRecognizerDelegate touchGestureRecognizer:self touchesMoved:touches withEvent:event];
    }
}


- (void)reset {}


- (void)ignoreTouch:(UITouch *)touch forEvent:(UIEvent *)event {}


- (BOOL)canBePreventedByGestureRecognizer:(UIGestureRecognizer *)preventingGestureRecognizer
{
    return NO;
}


- (BOOL)canPreventGestureRecognizer:(UIGestureRecognizer *)preventedGestureRecognizer
{
    return NO;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([touch.view isKindOfClass:UIButton.class])
    {
        return NO;
    }
    
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end

