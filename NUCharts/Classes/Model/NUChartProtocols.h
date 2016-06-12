//
//  NUChartProtocols.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartData.h"

#define NU_ABSTRACT_METHOD NSString *errorString = [NSString stringWithFormat:@"You must implement %@ in your subclass of NUChartBaseRenderer", __PRETTY_FUNCTION__];@throw [NSException exceptionWithName:@"Unimplemented method" reason:errorString userInfo:nil];

NS_ASSUME_NONNULL_BEGIN

@class NUChartRange;

// Interpolator

@protocol NUChartInterpolator <NSObject>
///Override point. Creates and returns a CGPath for the data set
- (CGPathRef)pathForData:(NUChartData *)data
                  xRange:(NUChartRange *)xRange
                  yRange:(NUChartRange *)yRange
                  bounds:(CGRect)bounds CF_RETURNS_RETAINED;
@end

// Renderer

@protocol NUChartRenderer <NSObject>
///Override point. Renders the data set into the rectangle determined by @c bounds and returns a CAShapeLayer
- (CAShapeLayer *__nullable)drawData:(NUChartData *)data
                              xRange:(NUChartRange *)xRange
                              yRange:(NUChartRange *)yRange
                              bounds:(CGRect)bounds;
@end

NS_ASSUME_NONNULL_END
