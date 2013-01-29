//
//	LTTabVector.h
//	LTTabVector
//
//	Created by Lex Tang on 3/22/12
//  Copyright (c) 2013 LexTang.com. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT const CGFloat kLTTabViewWidth;
FOUNDATION_EXPORT const CGFloat kLTTabViewHeight;
FOUNDATION_EXPORT const CGFloat kLTTabOuterHeight;
FOUNDATION_EXPORT const CGFloat kLTTabInnerHeight;
FOUNDATION_EXPORT const CGFloat kLTTabLineHeight;
FOUNDATION_EXPORT const CGFloat kLTTabCurvature;

@interface LTTabVector : UIView

@property (strong, nonatomic) UIColor *innerBackgroundColor;
@property (strong, nonatomic) UIColor *foregroundColor;

@end
