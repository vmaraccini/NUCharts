//
//  NUMonotoneCubicInterpolator.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import <Foundation/Foundation.h>
#import "NUChartProtocols.h"

/**
 @brief Smooth interpolator on the X axis.
 @discussion Joins two points by drawing a smooth UIBezier line between them such that the control points of each Bezier segment are parallel to the X axis.
 **/
@interface NUChartFlatYBezierInterpolator : NSObject <NUChartInterpolator>

///Determines how smooth the bezier path is between two points. Defaults to 0.3
@property (nonatomic) CGFloat smoothness;

@end
