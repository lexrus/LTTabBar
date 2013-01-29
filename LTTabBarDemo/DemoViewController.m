//
//  DemoViewController.m
//  LTTabBar
//
//  Created by Lex Tang on 3/23/12.
//  Copyright (c) 2012 LexTang.com. All rights reserved.
//

#import "DemoViewController.h"
#import "LTTabBar.h"

#define ARC4RANDOM_MAX 0x100000000

static UIColor *randomLightColor() {
    return [UIColor colorWithRed:(CGFloat) arc4random() / ARC4RANDOM_MAX + 0.2f
                           green:(CGFloat) arc4random() / ARC4RANDOM_MAX + 0.2f
                            blue:(CGFloat) arc4random() / ARC4RANDOM_MAX + 0.2f
                           alpha:0.95f];
}

@interface DemoViewController () {
    LTTabBar *_tabBar;
    NSMutableArray *_tabContents;
    UIView *_tabContentContainer;
}
@end

@implementation DemoViewController

#pragma mark - Life cycle
- (void)loadView {
    [super loadView];
    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];

    _tabContentContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
            self.view.bounds.size.width - kLTTabViewWidth, self.view.bounds.size.height)];
    _tabContentContainer.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _tabContentContainer.clipsToBounds = YES;
    [self.view addSubview:_tabContentContainer];

    _tabContents = [NSMutableArray array];

    _tabBar = [[LTTabBar alloc] init];
    _tabBar.backgroundColor = [UIColor darkGrayColor];
    _tabBar.frame = CGRectMake(self.view.bounds.size.width - kLTTabViewWidth,
            0, kLTTabViewWidth, self.view.frame.size.height);
    [self.view addSubview:_tabBar];
    [_tabBar setLayoutPosition:LTTabBarLayoutPositionRight];

    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [addButton setTitle:@"New LTTab" forState:UIControlStateNormal];
    addButton.frame = CGRectMake((self.view.bounds.size.width - kLTTabViewWidth - 200) / 2, 20, 200, 44);
    [addButton addTarget:self action:@selector(addTab:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

    UIButton *removeButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    removeButton.frame = CGRectMake((self.view.bounds.size.width - kLTTabViewWidth - 200) / 2, 64, 200, 44);
    [removeButton setTitle:@"Remove Last LTTab" forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeLastTab:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Button handler
- (void)addTab:(id)sender {
    UIColor *randColor = randomLightColor();
    UIButton *iconView = [UIButton buttonWithType:UIButtonTypeInfoDark];

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0,
            self.view.bounds.size.width - kLTTabViewWidth, self.view.bounds.size.height)];
    label.font = [UIFont boldSystemFontOfSize:36];
    label.textColor = randColor;
    label.text = [NSString stringWithFormat:@"LTTab #%i.", [_tabContents count]];
    label.textAlignment = (NSTextAlignment) UITextAlignmentCenter;
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(0.5f, 0.5f);
    [_tabContentContainer addSubview:label];

    [_tabContents addObject:label];

    __block DemoViewController *self_ = self;
    [_tabBar addTabWithIcon:iconView background:randColor handler:(LTTabBarTapHandler) ^(NSUInteger tabIndex) {
        [self_ activeContentViewByIndex:tabIndex];
    }];
}

- (void)activeContentViewByIndex:(NSUInteger)index {
    for (UIView *contentView in _tabContents) {
        contentView.hidden = YES;
    }
    UIView *activeView = (UIView *) [_tabContents objectAtIndex:index];
    activeView.hidden = NO;
    [_tabContentContainer bringSubviewToFront:activeView];
    [UIView animateWithDuration:0.2f animations:^{
        activeView.alpha = 1.0f;
    }];
}

- (void)removeLastTab:(id)sender {
    [_tabBar removeLastTabAnimated:YES];
    [[_tabContents lastObject] removeFromSuperview];
    [_tabContents removeLastObject];
}

@end
