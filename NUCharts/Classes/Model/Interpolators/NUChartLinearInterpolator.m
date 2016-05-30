//
//  NULinearChartInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartLinearInterpolator.h"

@implementation NUChartLinearInterpolator

- (CGPathRef)pathForData:(NUChartData *)data
{
    NSAssert(data.xValues.count == data.yValues.count,
             @"X and Y data should have the same count");
    NSAssert(data.xValues.count > 1, @"Should have at least 2 points");

    UIBezierPath *path = [UIBezierPath bezierPath];

    CGPoint __block previousPoint = CGPointMake(data.xValues[0].floatValue,
                                                data.yValues[0].floatValue);

    [data.xValues enumerateObjectsUsingBlock:^(NSNumber * _Nonnull x, NSUInteger idx, BOOL * _Nonnull stop) {
        //Skip first point
        if (idx == 0) {
            return;
        }

        [path moveToPoint:previousPoint];

        NSNumber *y = data.yValues[idx];
        CGPoint currentPoint = CGPointMake(x.floatValue,
                                           y.floatValue);

        [path addLineToPoint:currentPoint];
        previousPoint = currentPoint;
    }];

    return CFBridgingRetain(path.CGPath);
}

@end
