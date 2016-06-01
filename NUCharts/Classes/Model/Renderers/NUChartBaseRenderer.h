//
//  NUChartBaseRenderer.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import <Foundation/Foundation.h>
#import "NUChartProtocols.h"
#import "NUChartAxis.h"

NS_ASSUME_NONNULL_BEGIN

@interface NUChartBaseRenderer : NSObject <NUChartRenderer>

- (CAShapeLayer *__nullable)drawPath:(CGPathRef)path
                          withxRange:(NSRange)xRange
                              yRange:(NSRange)yRange
                              bounds:(CGRect)bounds;

@end

NS_ASSUME_NONNULL_END
