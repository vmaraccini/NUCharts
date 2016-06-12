//
//  NUChartFlatYBezierInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartFlatYBezierInterpolator.h"
#import "NUChartBaseInterpolator+Private.h"

@implementation NUChartFlatYBezierInterpolator

#pragma mark - Extension points

- (void)drawPoint:(CGPoint)currentPoint
    previousPoint:(CGPoint)previousPoint
    controlPoint1:(CGPoint)cp1
    controlPoint2:(CGPoint)cp2
             path:(UIBezierPath *)path
{
    CGPoint flatY1 = CGPointMake(cp1.x, previousPoint.y);
    CGPoint flatY2 = CGPointMake(cp2.x, currentPoint.y);
    [path addCurveToPoint:currentPoint
            controlPoint1:flatY1
            controlPoint2:flatY2];
}

@end
