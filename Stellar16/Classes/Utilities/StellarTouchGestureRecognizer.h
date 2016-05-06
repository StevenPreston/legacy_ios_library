//
//  StellarTouchGestureRecognizer.h
//  Hoppit
//
//  Created by Steven Preston on 9/24/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

@class StellarTouchGestureRecognizer;

@protocol StellarTouchGestureRecognizerDelegate <NSObject>

@optional
- (void)touchGestureRecognizer:(StellarTouchGestureRecognizer *)touchGestureRecognizer touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchGestureRecognizer:(StellarTouchGestureRecognizer *)touchGestureRecognizer touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchGestureRecognizer:(StellarTouchGestureRecognizer *)touchGestureRecognizer touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;

@end

@interface StellarTouchGestureRecognizer : UIGestureRecognizer <UIGestureRecognizerDelegate>

@property (weak, nonatomic) id <StellarTouchGestureRecognizerDelegate> touchGestureRecognizerDelegate;

@end
