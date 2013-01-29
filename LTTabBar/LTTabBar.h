//
//  LTTabBar.h
//  LTTabBar
//
//  Created by Lex Tang on 3/22/12.
//  Copyright (c) 2013 LexTang.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LTTabView.h"

#ifndef LEX_TAB_BAR_LAYOUT_POSITION
#define LEX_TAB_BAR_LAYOUT_POSITION
typedef enum _LTTabBarLayoutPosition {
    LTTabBarLayoutPositionTop = 1 << 0,
    LTTabBarLayoutPositionRight = 1 << 1,
    LTTabBarLayoutPositionBottom = 1 << 2,
    LTTabBarLayoutPositionLeft = 1 << 3
} LTTabBarLayoutPosition;
#endif

@interface LTTabBar : UIView

@property(nonatomic, assign) LTTabBarLayoutPosition layoutPosition;
@property(nonatomic, assign) NSUInteger selectedTabIndex;

- (void)setSelectedTabIndex:(NSUInteger)aSelectedTabIndex animated:(BOOL)animated;

- (void)addTabWithIcon:(UIView *)tabIcon background:(UIColor *)bgColor handler:(LTTabBarTapHandler)handler;

- (void)removeLastTabAnimated:(BOOL)animated;

@end
