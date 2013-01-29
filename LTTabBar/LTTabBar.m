//
//  LTTabBar.m
//  LTTabBar
//
//  Created by Lex Tang on 3/22/12.
//  Copyright (c) 2013 LexTang.com. All rights reserved.
//

#import "LTTabBar.h"

const CGFloat kTabMargin = - 30.0f;

static CGFloat degreesToRadians(int angle) {
    return (CGFloat) (angle / 180.0 * M_PI);
}

static CGAffineTransform CGAffineTransformMakeRotationAt(CGFloat angle, CGPoint pt) {
    const CGFloat fx = pt.x;
    const CGFloat fy = pt.y;
    const CGFloat fCos = (CGFloat) cos(angle);
    const CGFloat fSin = (CGFloat) sin(angle);
    return CGAffineTransformMake(fCos, fSin, -fSin, fCos, fx - fx * fCos + fy * fSin, fy - fx * fSin - fy * fCos);
}

@interface LTTabBar () {
    NSMutableArray *_tabs;
    UIScrollView *_tabScrollView;
    LTTabBarLayoutPosition _layoutPosition;
    NSInteger _selectedTabIndex;
}

- (CGRect)frameOfTabAtIndex:(NSUInteger)index;

- (void)tabTap:(UITapGestureRecognizer *)tap;

- (void)updateScrollViewContentSize;
@end

@implementation LTTabBar

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.frame = [[UIScreen mainScreen] bounds];
        self.clipsToBounds = YES;
        _tabScrollView = [[UIScrollView alloc] init];
        _tabScrollView.showsHorizontalScrollIndicator = NO;
        _tabScrollView.showsVerticalScrollIndicator = NO;
        _tabScrollView.bounces = YES;
        _tabScrollView.alwaysBounceVertical = YES;
        _tabScrollView.alwaysBounceHorizontal = NO;
        _tabScrollView.frame = self.bounds;
        _tabScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_tabScrollView];
        _layoutPosition = LTTabBarLayoutPositionRight;
        _tabs = [NSMutableArray array];

        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(tabTap:)];
        singleTap.numberOfTapsRequired = 1;
        singleTap.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:singleTap];
    }
    return self;
}

- (void)updateScrollViewContentSize {
    _tabScrollView.contentSize = CGSizeMake(kLTTabViewWidth, (kLTTabOuterHeight + kTabMargin) * [_tabs count]);
    [_tabScrollView scrollRectToVisible:CGRectMake(0,
            _tabScrollView.contentSize.height - kLTTabOuterHeight,
            1,
            kLTTabOuterHeight + kTabMargin)
                               animated:YES];
}

#pragma mark - Tab manager
- (void)addTabWithIcon:(UIView *)tabIcon background:(UIColor *)bgColor handler:(LTTabBarTapHandler)handler {
    LTTabView *tab = [[LTTabView alloc] initWithFrame:[self frameOfTabAtIndex:[_tabs count]]];
    tab.iconView = tabIcon;
    tab.opaque = YES;
    tab.handler = handler;
    tab.innerBackgroundColor = bgColor;
    tab.backgroundColor = [UIColor clearColor];
    tab.userInteractionEnabled = YES;
    [tab addSubview:tab.iconView];
    [_tabScrollView addSubview:tab];
    tab.index = [_tabs count];
    [_tabs addObject:tab];
    [self setSelectedTabIndex:tab.index animated:YES];
    [self updateScrollViewContentSize];
}

- (void)removeLastTabAnimated:(BOOL)animated {
    LTTabView *tab = (LTTabView *) [_tabs lastObject];
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            tab.alpha = .0;
        }                completion:^(BOOL finished) {
            [tab removeFromSuperview];
        }];
    }
    else {
        [tab removeFromSuperview];
    }
    [_tabs removeLastObject];
    [self setSelectedTabIndex:[_tabs count] - 1 animated:animated];
    if (animated) {
        [UIView animateWithDuration:.2 animations:^{
            [self updateScrollViewContentSize];
        }];
    }
    else {
        [self updateScrollViewContentSize];
    }
}

- (void)tabTap:(UITapGestureRecognizer *)tap {
    CGPoint location = [tap locationInView:_tabScrollView];
    uint touchedIndex = ceilf(location.y / (kLTTabOuterHeight + kTabMargin)) - 1;
    [self setSelectedTabIndex:touchedIndex animated:YES];
}

- (CGRect)frameOfTabAtIndex:(NSUInteger)index {
    return CGRectMake(0,
            -(kLTTabViewHeight - kLTTabOuterHeight - kTabMargin) / 2 + (kLTTabOuterHeight + kTabMargin) * index,
            kLTTabViewWidth, kLTTabViewHeight);
}

- (void)setSelectedTabIndex:(NSUInteger)aSelectedTabIndex {
    aSelectedTabIndex = MIN([_tabs count] - 1, aSelectedTabIndex);
    if (_selectedTabIndex != aSelectedTabIndex && [_tabs count] > 0) {
        _selectedTabIndex = MIN([_tabs count] - 1, _selectedTabIndex);
        LTTabView *tab = (LTTabView *) [_tabs objectAtIndex:_selectedTabIndex];
        [tab setActive:NO];
        tab = (LTTabView *) [_tabs objectAtIndex:aSelectedTabIndex];
        [_tabScrollView bringSubviewToFront:tab];
        [tab setActive:YES];
        tab.handler(aSelectedTabIndex);
        _selectedTabIndex = aSelectedTabIndex;
    }
}

- (void)setSelectedTabIndex:(NSUInteger)aSelectedTabIndex animated:(BOOL)animated {
    if (animated)
        [UIView animateWithDuration:.2 animations:^{
            [self setSelectedTabIndex:aSelectedTabIndex];
        }];
    else
        [self setSelectedTabIndex:aSelectedTabIndex];
}

- (NSUInteger)selectedTabIndex {
    return _selectedTabIndex;
}

- (void)setLayoutPosition:(LTTabBarLayoutPosition)aLayoutPosition {
    if (aLayoutPosition & LTTabBarLayoutPositionTop) {
        _tabScrollView.transform = CGAffineTransformMakeRotationAt(
                degreesToRadians(-90),
                CGPointMake(kLTTabViewWidth + kLTTabOuterHeight + kTabMargin, kLTTabViewWidth - kLTTabOuterHeight + kTabMargin));
    }
    else if (aLayoutPosition & LTTabBarLayoutPositionLeft) {
        _tabScrollView.transform = CGAffineTransformMakeRotationAt(degreesToRadians(-180), CGPointMake(0, 0));
    }
    else if (aLayoutPosition & LTTabBarLayoutPositionBottom) {
        _tabScrollView.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
    }
}

- (LTTabBarLayoutPosition)layoutPosition {
    return _layoutPosition;
}

@end
