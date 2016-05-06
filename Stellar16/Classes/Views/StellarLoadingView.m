//
//  StellarLoadingView.m
//  Hoppit
//
//  Created by Steven Preston on 7/20/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "StellarLoadingView.h"

@implementation StellarLoadingView

- (void)showLoading:(BOOL)loading Message:(NSString *)message Animated:(BOOL)animated
{
    float duration = animated ? 0.3f : 0;
    [UIView animateWithDuration:duration animations:^
    {
        if (loading)
        {
            self.alpha = 1.0;
            [_activityIndicator startAnimating];
            _label.text = message;
        }
        else
        {
            self.alpha = 0;
            [_activityIndicator stopAnimating];
        }
        _refreshButton.alpha = 0;
    }];
}


- (void)showMessage:(NSString *)message ShowRefreshButton:(BOOL)showRefreshButton;
{
	showingMessage = YES;
    
    self.alpha = 1.0;
    _refreshButton.alpha = showRefreshButton ? 1.0f : 0;
    
    _label.text = message;
    [_activityIndicator stopAnimating];
}

@end
