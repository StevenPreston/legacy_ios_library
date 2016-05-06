//
//  StellarLoadingView.h
//  Hoppit
//
//  Created by Steven Preston on 7/20/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

@interface StellarLoadingView : UIView
{
	BOOL showingMessage;
}

@property (strong, nonatomic) IBOutlet UILabel *label;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) IBOutlet UIButton *refreshButton;

- (void)showLoading:(BOOL)loading Message:(NSString *)message Animated:(BOOL)animated;
- (void)showMessage:(NSString *)message ShowRefreshButton:(BOOL)showRefreshButton;

@end
