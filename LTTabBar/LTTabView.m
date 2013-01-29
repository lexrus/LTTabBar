//
//  LTTabView.m
//  LTTabBar
//
//  Created by Lex Tang on 3/22/12.
//  Copyright (c) 2013 LexTang.com. All rights reserved.
//

#import "LTTabView.h"

@interface LTTabView () {
    BOOL _active;
    UIView *_iconView;
}

@end

@implementation LTTabView
@synthesize handler, index;

- (void)setActive:(BOOL)isActive {
    if (isActive) {
        self.transform = CGAffineTransformMakeScale(1.15f, 1.15f);
        self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeTranslation(4.0f, 0.0f));
        _iconView.transform = CGAffineTransformIdentity;
    }
    else {
        self.transform = CGAffineTransformIdentity;
        _iconView.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    }
}

- (void)setActive:(BOOL)isActive animated:(BOOL)isAnimated {
    if (isAnimated) {
        [UIView animateWithDuration:0.25f
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self setActive:isActive];
        }                completion:nil];
    }
    else {
        [self setActive:isActive];
    }
}

- (BOOL)active {
    return _active;
}

#pragma mark - Set icon
- (void)setIconView:(UIView *)aIconView {
    _iconView = aIconView;
    _iconView.center = CGPointMake(kLTTabLineHeight / 2.0f + 6.0f, kLTTabViewHeight / 2.0f);
    _iconView.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    [self addSubview:_iconView];
}

- (UIView *)iconView {
    return _iconView;
}

@end
