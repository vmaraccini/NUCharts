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

@property (nonatomic, strong) CAShapeLayer *shapeLayer;

- (CGPathRef)pathForData:(NUChartData*)data
              withxRange:(NUChartRange *)xRange
                  yRange:(NUChartRange *)yRange
                  bounds:(CGRect)bounds;

@end

NS_ASSUME_NONNULL_END
