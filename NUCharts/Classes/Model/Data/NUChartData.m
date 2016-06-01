//
//  NUChartData.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartData.h"

@implementation NUChartData

- (instancetype)initWithxValues:(NSArray<NSNumber *>*)xValues
                        yValues:(NSArray<NSNumber *>*)yValues {
    NSAssert(xValues.count == yValues.count, @"X and Y values should have the same count");

    NSMutableArray *points = [NSMutableArray new];
    for (int i = 0; i < xValues.count; i++) {
        CGPoint point = CGPointMake(xValues[i].doubleValue, yValues[i].doubleValue);
        [points addObject:[NSValue valueWithCGPoint:point]];
    }

    return [self initWithCGPointArray:points];
}

- (instancetype)initWithCGPointArray:(NSArray<NSValue *>*)points {
    self = [super init];
    if (self) {

        for (NSValue *wrapped in points) {
            CGPoint point = wrapped.CGPointValue;
            _minimumX = MIN(_minimumX, point.x);
            _minimumY = MIN(_minimumY, point.y);
            _maximumX = MAX(_maximumX, point.x);
            _maximumY = MAX(_maximumY, point.y);
        }
        _points = points;
    }
    return self;
}

@end
