//
//  StellarFadeImageView.h
//  Stellar16
//
//  Created by Steven Preston on 7/30/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

@class StellarFadeImageView;

#define STELLAR_FADE_IMAGE_VIEW_FADE_DURATION 0.4f

@protocol StellarFadeImageViewDelegate <NSObject>

- (void)imageViewImageLoaded:(StellarFadeImageView *)imageView;

@end

@interface StellarFadeImageView : UIView

@property (assign, nonatomic) IBOutlet id<StellarFadeImageViewDelegate> delegate;
@property (strong, nonatomic) UIImageView *placeholderImageView;
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) CGFloat fadeDuration;

- (void)setImageWithURL:(NSURL *)url;
- (void)setPlaceHolder:(NSString *)placeholder;
- (void)imageLoaded;

@end
