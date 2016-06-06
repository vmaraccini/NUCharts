//
//  NUChartBaseRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartBaseRenderer.h"

@implementation NUChartBaseRenderer

- (CAShapeLayer *__nullable)drawPath:(CGPathRef)path
                          withxRange:(NSRange)xRange
                              yRange:(NSRange)yRange
                              bounds:(CGRect)bounds
{
    if (CGRectIsEmpty(bounds)) {
        return nil;
    }

    CAShapeLayer *shape = [CAShapeLayer layer];
    shape.path = path;
    
    return shape;
}

- (CAShapeLayer *)drawData:(NUChartData *)data bounds:(CGRect)bounds
{
    NU_ABSTRACT_METHOD
}

@end
