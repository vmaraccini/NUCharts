//
//  NUBaseInterpolator.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import <Foundation/Foundation.h>
#import "NUChartProtocols.h"

@interface NUChartBaseInterpolator : NSObject<NUChartInterpolator>

/**Override point. Draws a set of filtered points onto the internal path
 @remarks: The incoming array @c points is an array of NSValue-wrapped CGPoints.
 */
- (void)drawPoints:(NSArray<NSValue *>*)points;

@end
