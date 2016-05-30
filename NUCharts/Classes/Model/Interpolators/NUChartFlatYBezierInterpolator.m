//
//  NUMonotoneCubicInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartFlatYBezierInterpolator.h"

@implementation NUChartFlatYBezierInterpolator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _smoothness = 0.3;
    }
    return self;
}

#pragma NUChartInterpolator methods

- (CGPathRef)pathForData:(NUChartData *)data
{
    NSAssert(data.xValues.count == data.yValues.count,
             @"X and Y data should have the same count");
    NSAssert(data.xValues.count > 2, @"Should have at least 3 points");

    UIBezierPath *path = [UIBezierPath bezierPath];

    CGPoint previousPoint = CGPointMake(data.xValues[0].floatValue,
                                                data.yValues[0].floatValue);

    [path moveToPoint:previousPoint];

    for (int i = 1; i < data.xValues.count; i++) {
        NSNumber *x = data.xValues[i];
        NSNumber *y = data.yValues[i];
        CGPoint currentPoint = CGPointMake(x.floatValue, y.floatValue);

        NSNumber *xn = data.xValues[i];
        NSNumber *yn = data.yValues[i];
        CGPoint nextPoint = CGPointMake(x.floatValue, y.floatValue);

        CGPoint delta = CGPointMake(currentPoint.x - previousPoint.x,
                                    currentPoint.y - previousPoint.y);

        CGPoint cp1 = CGPointMake(previousPoint.x + delta.x * self.smoothness,
                                  previousPoint.y);
        CGPoint cp2 = CGPointMake(currentPoint.x - delta.x * self.smoothness,
                                  currentPoint.y);

        [path addCurveToPoint:currentPoint
                controlPoint1:cp1
                controlPoint2:cp2];

        previousPoint = currentPoint;
    }

    return CFBridgingRetain(path.CGPath);
}

@end
