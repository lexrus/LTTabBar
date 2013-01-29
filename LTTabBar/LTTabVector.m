//
//	LTTabVector.m
//	LTTabVector
//
//	Created by Lex Tang on 3/22/12
//  Copyright (c) 2013 LexTang.com. All rights reserved.
//

#import "LTTabVector.h"

const CGFloat kLTTabViewWidth = 60.0f;
const CGFloat kLTTabViewHeight = 2048.0f;
const CGFloat kLTTabInnerHeight = 80.0f;
const CGFloat kLTTabOuterHeight = 130.0f;
const CGFloat kLTTabLineHeight = 20.0f;
const CGFloat kLTTabCurvature = 10.0f;

@implementation LTTabVector

@synthesize innerBackgroundColor;
@synthesize foregroundColor;

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		innerBackgroundColor = [UIColor colorWithRed:1.0f green:0.502f blue:0.0f alpha:1.0f];
		foregroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f];
		[self setOpaque:NO];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)coder
{
	self = [super initWithCoder:coder];
	if (self) {
		innerBackgroundColor = [UIColor colorWithRed:1.0f green:0.502f blue:0.0f alpha:1.0f];
		foregroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.2f];
		[self setOpaque:NO];
	}
	return self;
}

- (void)setInnerBackgroundColor:(UIColor *)color
{
	if ([innerBackgroundColor isEqual:color]) {
		return;
	}
	innerBackgroundColor = color;
	[self setNeedsDisplay];
}

- (void)setForegroundColor:(UIColor *)color
{
	if ([foregroundColor isEqual:color]) {
		return;
	}
	foregroundColor = color;
	[self setNeedsDisplay];
}

- (CGSize)sizeThatFits:(CGSize)size
{
	return CGSizeMake(kLTTabViewWidth, kLTTabViewHeight);
}

- (void)drawRect:(CGRect)dirtyRect
{
	CGRect imageBounds = CGRectMake(0.0f, 0.0f, kLTTabViewWidth, kLTTabViewHeight);
	CGRect bounds = [self bounds];
	CGContextRef context = UIGraphicsGetCurrentContext();
	UIColor *color;
	CGMutablePathRef path;
	CGPoint point;
	CGFloat lengths[2];
    CGFloat cornerOffset = (kLTTabOuterHeight - kLTTabInnerHeight) / 2;
    CGFloat startY = (kLTTabViewHeight - kLTTabOuterHeight) / 2;
	
	CGContextSaveGState(context);
	CGContextTranslateCTM(context, bounds.origin.x, bounds.origin.y);
	CGContextScaleCTM(context, (bounds.size.width / imageBounds.size.width), (bounds.size.height / imageBounds.size.height));

#pragma mark - Shadow Begin

	color = [UIColor colorWithWhite:0.1f alpha:0.3f];
    CGContextSaveGState(context);
	CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.5f), 7.0f, [color CGColor]);
	CGContextBeginTransparencyLayer(context, NULL);
	
#pragma mark - Tab

	path = CGPathCreateMutable();
	point = CGPointMake(6.0f, startY);
	CGPathMoveToPoint(path, NULL, point.x, point.y);

#pragma mark - Top Curve

    CGPathAddCurveToPoint(path, NULL,
            6.0f, startY + kLTTabCurvature,
            6.0f + kLTTabLineHeight, startY + cornerOffset - kLTTabCurvature,
            6.0f + kLTTabLineHeight, startY + cornerOffset);

    CGPathAddLineToPoint(path, NULL, 6.0f + kLTTabLineHeight, startY + kLTTabInnerHeight + cornerOffset);

#pragma mark - Bottom Curve

    CGPathAddCurveToPoint(path, NULL,
            6.0f + kLTTabLineHeight, startY + kLTTabInnerHeight + cornerOffset + kLTTabCurvature,
            6.0f, startY + cornerOffset * 2 - kLTTabCurvature + kLTTabInnerHeight,
            6.0f, startY + cornerOffset * 2 + kLTTabInnerHeight);

    CGPathAddLineToPoint(path, NULL, 6.0f, kLTTabViewHeight);
    CGPathAddLineToPoint(path, NULL, 0.0f, kLTTabViewHeight);
    CGPathAddLineToPoint(path, NULL, 0.0f, 0.0f);
    CGPathAddLineToPoint(path, NULL, 6.0f, 0.0f);

	CGPathCloseSubpath(path);
	[[self innerBackgroundColor] setFill];
	CGContextAddPath(context, path);
	CGContextFillPath(context);
	CGPathRelease(path);


#pragma mark - Shadow End

	CGContextEndTransparencyLayer(context);
	CGContextRestoreGState(context);
	
#pragma mark - Dots

	path = CGPathCreateMutable();
	point = CGPointMake(6.0f, startY + cornerOffset / 2);
	CGPathMoveToPoint(path, NULL, point.x, point.y);
	point = CGPointMake(6.0f, startY + kLTTabCurvature + kLTTabOuterHeight - kLTTabCurvature * 2);
	CGPathAddLineToPoint(path, NULL, point.x, point.y);
	[[self foregroundColor] setStroke];
	CGContextSetLineWidth(context, 1.0f);
	CGContextSetLineCap(context, kCGLineCapRound);
	CGContextSetLineJoin(context, kCGLineJoinRound);
	lengths[0] = 1.0f;
	lengths[1] = 2.0f;
	CGContextSetLineDash(context, 0.0f, lengths, 2);
	CGContextAddPath(context, path);
	CGContextStrokePath(context);
	CGPathRelease(path);
	
	CGContextRestoreGState(context);
}

@end
