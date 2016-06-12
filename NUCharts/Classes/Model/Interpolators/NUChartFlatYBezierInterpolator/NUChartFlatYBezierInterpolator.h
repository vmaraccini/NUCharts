//
//  NUChartFlatYBezierInterpolator.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartBezierInterpolator.h"

/**
 @brief Smooth interpolator on the X axis.
 @discussion Joins two points by drawing a smooth UIBezier line between them such that the control points of each Bezier segment are parallel to the X axis.
 **/
@interface NUChartFlatYBezierInterpolator : NUChartBezierInterpolator

@end
