//
//  StellarFadeImageView.m
//  MedWorldLive
//
//  Created by Steven Preston on 7/30/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import "StellarFadeImageView.h"
#import "UIImageView+AFNetworking.h"

/**
 * Private class for fading in an image view when the image is set for the first time.
 */
@interface _FadeInImageView : UIImageView

@property (assign, nonatomic) CGFloat fadeDuration;

@end

@implementation _FadeInImageView

- (void)setImage:(UIImage *)newImage
{
    BOOL firstImage = NO;
    if (self.image == nil)
    {
        firstImage = YES;
        self.alpha = 0;
    }
    
    [super setImage:newImage];
    
    if (firstImage)
    {
        [UIView animateWithDuration:self.fadeDuration delay:0 options:UIViewAnimationOptionCurveEaseOut
                         animations:^
         {
             self.alpha = 1.0f;
         }
                         completion:nil];
    }
    
    if (newImage != nil)
    {
        [((StellarFadeImageView *)self.superview) imageLoaded];
    }
}

@end

@implementation StellarFadeImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self awakeFromNib];
    }
    return self;
}


- (void)awakeFromNib
{
    self.placeholderImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self insertSubview:_placeholderImageView atIndex:0];
    
    self.imageView = [[_FadeInImageView alloc] initWithFrame:self.bounds];
    [self addSubview:_imageView];
    
    _placeholderImageView.autoresizingMask = _imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    
    self.userInteractionEnabled = NO;
    self.fadeDuration = STELLAR_FADE_IMAGE_VIEW_FADE_DURATION;
}


- (void)setPlaceHolder:(NSString *)placeholder
{
    if (placeholder == nil)
    {
        self.placeholderImageView.image = nil;
    }
    else
    {
        self.placeholderImageView.image = [UIImage imageNamed:placeholder];
    }
}


- (UIImage *)image
{
    return _imageView.image;
}


- (void)setImage:(UIImage *)newImage
{
    _imageView.image = newImage;
}


- (void)setImageWithURL:(NSURL *)url
{
    [_imageView setImageWithURL:url];
}


- (void)setContentMode:(UIViewContentMode)contentMode
{
    _imageView.contentMode = contentMode;
}


- (void)setFadeDuration:(CGFloat)fadeDuration
{
    _fadeDuration = fadeDuration;
    ((_FadeInImageView *) _imageView).fadeDuration = fadeDuration;
}


- (void)imageLoaded
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(imageViewImageLoaded:)])
    {
        [_delegate imageViewImageLoaded:self];
    }    
}

@end
