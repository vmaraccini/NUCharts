//
//  NUChartBaseRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartBaseRenderer.h"

@interface NUChartBaseRenderer ()
@property (nonatomic) BOOL batch;
@property (nonatomic) CGPathRef batchRef;
@end

@implementation NUChartBaseRenderer

- (nullable CAShapeLayer *)updatePath:(CGPathRef)path
                               bounds:(CGRect)bounds
                             animated:(BOOL)animated

{
    if (!self.shapeLayer) {
        return [self drawPath:path bounds:bounds];
    } else {
        if (!animated && !self.batch) {
            [CATransaction begin];
            [CATransaction setAnimationDuration:0];
        }

        self.shapeLayer.path = path;
        [self willUpdate];

        if (!animated && !self.batch) {
            [CATransaction commit];
        }

        return self.shapeLayer;
    }
}

- (nullable CAShapeLayer *)drawPath:(CGPathRef)path
                             bounds:(CGRect)bounds
{
    if (CGRectIsEmpty(bounds)) {
        return nil;
    }

    if (!self.shapeLayer) {
        self.shapeLayer = [CAShapeLayer layer];
    }

    self.shapeLayer.path = path;
    [self willUpdate];

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
        CGPathRef path = [self pathForData:data
                                withxRange:xRange
                                    yRange:yRange
                                    bounds:bounds];
        [self willUpdate];

        return [self drawPath:path bounds:bounds];
    }

    CGPathRef newPath = [self pathForData:data
                               withxRange:xRange
                                   yRange:yRange
                                   bounds:bounds];

    [self updatePath:newPath bounds:bounds animated:animated];

    [self willUpdate];
    return self.shapeLayer;
}

- (CGRect)boundingRect
{
    return CGPathGetPathBoundingBox(self.shapeLayer.path);
}

- (void)willUpdate
{
    [self.delegate rendererWillUpdate:self];
}

#pragma mark - Base shape animation

-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    if ([event isEqualToString:@"path"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        CGPathRef from = self.batch ? self.batchRef : self.shapeLayer.path;

        animation.fromValue = (__bridge id _Nullable)from;
        return animation;
    }
    return nil;
}

- (void)startBatchAnimations
{
    _batch = YES;
    _batchRef = self.shapeLayer.path;
}

- (void)endBatchAnimations
{
    _batch = NO;
    _batchRef = nil;
}

@end
