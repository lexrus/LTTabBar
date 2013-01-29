//
//  LTTabView.h
//  LTTabBar
//
//  Created by Lex Tang on 3/22/12.
//  Copyright (c) 2013 LexTang.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LTTabVector.h"

#if NS_BLOCKS_AVAILABLE
#ifndef LEX_TAB_BLOCK
#define LEX_TAB_BLOCK

typedef void (^LTTabBarTapHandler)(NSUInteger tabIndex);

#endif
#endif

@interface LTTabView : LTTabVector

@property(nonatomic, assign) BOOL active;

@property(nonatomic, strong) UIView *iconView;
@property(nonatomic, strong) LTTabBarTapHandler handler;
@property(nonatomic, assign) NSUInteger index;

- (void)setActive:(BOOL)isActive animated:(BOOL)isAnimated;

@end
