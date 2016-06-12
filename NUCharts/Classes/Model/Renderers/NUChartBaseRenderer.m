//
//  NUChartBaseRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartBaseRenderer.h"

@implementation NUChartBaseRenderer

- (CAShapeLayer *)drawData:(NUChartData *)data
                    xRange:(NUChartRange *)xRange
                    yRange:(NUChartRange *)yRange
                    bounds:(CGRect)bounds
{
    if (CGRectIsEmpty(bounds)) {
        return nil;
    }

    CGPathRef path = [self pathForData:data
                            withxRange:xRange
                                yRange:yRange
                                bounds:bounds];

    self.shapeLayer = [CAShapeLayer layer];
    self.shapeLayer.path = path;

    return self.shapeLayer;
}

- (CGPathRef)pathForData:(NUChartData*)data
              withxRange:(NUChartRange *)xRange
                  yRange:(NUChartRange *)yRange
                  bounds:(CGRect)bounds
{
    NU_ABSTRACT_METHOD
}

- (CAShapeLayer *)updateData:(NUChartData *)data
                      xRange:(NUChartRange *)xRange
                      yRange:(NUChartRange *)yRange
                      bounds:(CGRect)bounds
                    animated:(BOOL)animated
{

    if (!self.shapeLayer) {
        return [self drawData:data
                       xRange:xRange
                       yRange:yRange
                       bounds:bounds];
    }

    if (!animated) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0];
    }

    self.shapeLayer.path = [self pathForData:data
                                  withxRange:xRange
                                      yRange:yRange
                                      bounds:bounds];

    if (!animated) {
        [CATransaction commit];
    }

    return self.shapeLayer;
}

#pragma mark - Base shape animation

-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    if ([event isEqualToString:@"path"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = (__bridge id _Nullable)(self.shapeLayer.path);
        return animation;
    }
    return nil;
}

@end
