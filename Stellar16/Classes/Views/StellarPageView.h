//
//  StellarPageView.h
//  Hoppit
//
//  Created by Steven Preston on 10/10/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

@interface StellarPageView : UIView <UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSMutableArray *viewControllers;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIPageControl *pageControl;
@property (readonly, nonatomic) UIViewController *currentViewController;
@property (assign, nonatomic) int currentPageIndex;

- (void)addData:(NSArray *)data;
- (IBAction)pageControlValueChanged:(id)sender;
- (UIViewController *)loadViewControllerAtIndex:(int)index;
- (void)addViewControllerAtIndex:(int)index;
- (void)removeViewControllerAtIndex:(int)index;
- (void)scrollToPage:(int)index;

@end
