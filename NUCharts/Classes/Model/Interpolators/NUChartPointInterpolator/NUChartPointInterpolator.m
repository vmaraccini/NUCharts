//
//  NUChartPointInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartPointInterpolator.h"
#import "NUChartBaseInterpolator+Private.h"

@implementation NUChartPointInterpolator

- (void)drawPoints:(NSArray<NSValue *> *)points {
    for (int i = 0; i < points.count; i++) {
        CGPoint point = points[i].CGPointValue;
        point = CGPointApplyAffineTransform(point, self.scaleTransform);

        CGPathAddEllipseInRect(self.mutablePath, NULL,
                               CGRectMake(point.x - self.diameter / 2.f,
                                          point.y - self.diameter / 2.f,
                                          self.diameter,
                                          self.diameter));
    }
}

@end
