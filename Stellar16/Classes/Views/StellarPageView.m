//
//  StellarPageView.m
//  Hoppit
//
//  Created by Steven Preston on 10/10/12.
//  Copyright (c) 2012 Stellar16. All rights reserved.
//

#import "StellarPageView.h"

@implementation StellarPageView

#pragma mark - Setter Methods

- (void)setData:(NSArray *)data
{
    if ([_data isEqualToArray:data])
    {
        return;
    }
    
    NSArray *oldData = _data;
    NSArray *oldViewControllers = _viewControllers;
    _data = [NSMutableArray arrayWithArray:data];
    
    //Reset place views.
    for (UIView *view in [_scrollView subviews])
    {
        [view removeFromSuperview];
    }
    
    //Initialise an array of null objects to hold place view controllers.
    self.viewControllers = [NSMutableArray arrayWithCapacity:_data.count];
    for (id item in _data)
    {
        //Recycle old view controllers.
        int index = [oldData indexOfObject:item];
        if (oldData != nil && index != NSNotFound)
        {
            UIViewController *oldViewController = [oldViewControllers objectAtIndex:index];
            [_viewControllers addObject:oldViewController];
        }
        else
        {
            [_viewControllers addObject:[NSNull null]];
        }
    }
    
    //Reset scroller without animation.
    _scrollView.contentOffset = CGPointZero;
    _scrollView.contentSize = CGSizeMake(_data.count * _scrollView.frame.size.width, _scrollView.frame.size.height);
    _scrollView.pagingEnabled = YES;
    
    //Update page control
    if (_pageControl != nil)
    {
        _pageControl.numberOfPages = _data.count;
        [_pageControl addTarget:self action:@selector(pageControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    //Load first view controller.
    [self scrollViewDidScroll:_scrollView];
}


- (void)addData:(NSArray *)data
{
    if (_data == nil)
    {
        [self setData:data];
    }
    else
    {
        [(NSMutableArray *)_data addObjectsFromArray:data];
        
        for (id item in data)
        {
            [_viewControllers addObject:[NSNull null]];
        }
        
        //Reset scroller without animation.
        _scrollView.contentSize = CGSizeMake(_data.count * _scrollView.frame.size.width, _scrollView.frame.size.height);
        
        //Update page control
        if (_pageControl != nil)
        {
            _pageControl.numberOfPages = _data.count;
        }
    }
}


- (void)setCurrentPageIndex:(int)currentPageIndex
{
    _currentPageIndex = currentPageIndex;
    if (_pageControl != nil)
    {
        _pageControl.currentPage = _currentPageIndex;
    }
}


#pragma mark - Getter Methods

- (UIViewController *)currentViewController
{
    UIViewController *viewController = nil;
    
    float x = _scrollView.contentOffset.x;
    int index = x / _scrollView.frame.size.width;
    
    if (index >= 0 && index < [_viewControllers count])
    {
        viewController = [_viewControllers objectAtIndex:index];
    }
    
    return viewController;
}


#pragma mark - UI Action Methods

- (IBAction)pageControlValueChanged:(id)sender
{
    [self scrollToPage:_pageControl.currentPage];
}


#pragma mark - UI Helper Methods

- (UIViewController *)loadViewControllerAtIndex:(int)index
{
    //Override
    return NULL;
}


- (void)addViewControllerAtIndex:(int)index
{
    if (index < 0 || index >= _data.count)
    {
        return;
    }
    
    UIViewController *viewController = nil;
    id controller = [_viewControllers objectAtIndex:index];
    if (controller == [NSNull null])
    {
        viewController = [self loadViewControllerAtIndex:index];
        [_viewControllers replaceObjectAtIndex:index withObject:viewController];
    }
    else
    {
        viewController = controller;
    }
    
    CGRect frame = viewController.view.frame;
    frame.origin.x = index * _scrollView.frame.size.width;
    frame.size.height = _scrollView.frame.size.height;
    
    //This should already be the case in the nib files but we reset it here just in case.
    frame.size.width = _scrollView.frame.size.width;
    viewController.view.frame = frame;
    
    //Only attempt to add the view if it is not already added.
    if (viewController.view.superview == nil)
    {
        [_scrollView addSubview:viewController.view];
    }
}


- (void)removeViewControllerAtIndex:(int)index
{
    if (index < 0 || index >= _data.count)
    {
        return;
    }
    UIViewController *viewController = nil;
    id controller = [_viewControllers objectAtIndex:index];
    if (controller != [NSNull null])
    {
        viewController = controller;
        [viewController.view removeFromSuperview];
    }
}


- (void)scrollToPage:(int)index
{
    if (index >= 0 && index < _data.count)
    {
        CGRect frame = _scrollView.bounds;
        frame.origin.x = frame.size.width * (index);
        [_scrollView scrollRectToVisible:frame animated:YES];
        
        self.currentPageIndex = index;
    }
}


#pragma mark - UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float x = scrollView.contentOffset.x;
    int index = x / _scrollView.frame.size.width;
    
    self.currentPageIndex = index;
    
    //Load current, previous and next views.
    [self addViewControllerAtIndex:index];
    [self addViewControllerAtIndex:index - 1];
    [self addViewControllerAtIndex:index + 1];
    
    [self removeViewControllerAtIndex:index - 2];
    [self removeViewControllerAtIndex:index + 2];
}


/*
 * Ensures that if paging is disabled, a page is always landed on after a user has scrolled.
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    float nearestIndex = roundf(targetContentOffset->x / scrollView.frame.size.width);
    
    //Fix for iOS bug.
    float offsetX = nearestIndex * scrollView.frame.size.width;
    if (offsetX == 0)
    {
        offsetX += 0.1f;
    }
    else if (offsetX == (self.data.count - 1) * scrollView.frame.size.width)
    {
        offsetX -= 0.1f;
    }
    
    targetContentOffset->x = offsetX;
}

@end
