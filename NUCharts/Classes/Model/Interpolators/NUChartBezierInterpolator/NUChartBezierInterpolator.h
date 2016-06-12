//
//  NUChartBezierInterpolator.h
//  Pods
//
//  Created by Victor Maraccini on 6/12/16.
//
//

#import "NUChartBaseInterpolator.h"

/**
 @brief Smooth interpolator on both X and Y axes.
 @discussion Joins two points by drawing a smooth UIBezier line between them.
 **/
@interface NUChartBezierInterpolator : NUChartBaseInterpolator

@property (nonatomic, readonly) NSMutableArray<NSValue *>*ctrlPoints1;
@property (nonatomic, readonly) NSMutableArray<NSValue *>*ctrlPoints2;

- (void)drawPoint:(CGPoint)currentPoint
    previousPoint:(CGPoint)previousPoint
    controlPoint1:(CGPoint)cp1
    controlPoint2:(CGPoint)cp2
             path:(UIBezierPath *)path;

@end
