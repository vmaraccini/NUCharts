//
//  NULinearChartInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartLinearInterpolator.h"
#import "NUChartBaseInterpolator+Private.h"

@implementation NUChartLinearInterpolator

- (void)drawPoints:(NSArray<NSValue *> *)points
{
    CGPoint __block previousPoint = points[0].CGPointValue;

    [points enumerateObjectsUsingBlock:^(NSValue * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //Skip first point
        if (idx == 0) {
            return;
        }
        CGPoint currentPoint = obj.CGPointValue;

        CGAffineTransform t = self.scaleTransform;
        CGPathMoveToPoint(self.mutablePath, &t, previousPoint.x, previousPoint.y);
        CGPathAddLineToPoint(self.mutablePath, &t, currentPoint.x, currentPoint.y);
        
        previousPoint = currentPoint;
    }];
}

@end
