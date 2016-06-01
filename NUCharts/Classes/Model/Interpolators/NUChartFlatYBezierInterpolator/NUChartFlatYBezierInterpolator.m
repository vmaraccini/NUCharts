//
//  NUMonotoneCubicInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartFlatYBezierInterpolator.h"
#import "NUChartBaseInterpolator+Private.h"

@implementation NUChartFlatYBezierInterpolator

- (instancetype)init
{
    self = [super init];
    if (self) {
        _smoothness = 0.3;
    }
    return self;
}

#pragma mark - Extension points

- (void)drawPoints:(NSArray<NSValue *> *)points
{
    if (points.count < 3) {
        self.mutablePath = NULL;
    }

    UIBezierPath *path = [UIBezierPath bezierPath];

    CGPoint previousPoint = CGPointApplyAffineTransform(points[0].CGPointValue, self.scaleTransform);
    [path moveToPoint:previousPoint];

    for (int i = 1; i < points.count; i++) {
        CGPoint currentPoint = CGPointApplyAffineTransform(points[i].CGPointValue, self.scaleTransform);;

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

    self.mutablePath = CFBridgingRetain(path.CGPath);
}

@end
