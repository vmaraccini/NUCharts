//
//  NUChartAxisRenderer.m
//  Pods
//
//  Created by Victor Maraccini on 6/14/16.
//
//

#import "NUChartAxisRenderer.h"
#import "NUChartProtocols.h"
#import "NUChartLinearInterpolator.h"
#import "NUChartAxis.h"

@interface NUChartAxisRenderer ()
@property (nonatomic) CGAffineTransform axisTransform;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, strong) CAShapeLayer *ticksLayer;
@property (nonatomic, strong) CAShapeLayer *majorLinesLayer;
@property (nonatomic, strong) CAShapeLayer *minorLinesLayer;

@property (nonatomic, readwrite) CGFloat oldXScaleFactor;
@property (nonatomic, readwrite) CGFloat oldYScaleFactor;
@end

@implementation NUChartAxisRenderer

- (CAShapeLayer *)updateAxis:(NUChartAxis *)axis
             orthogonalRange:(NUChartRange *)orthogonalRange
                 orientation:(NUChartAxisOrientation)orientation
                      bounds:(CGRect)bounds
                    animated:(BOOL)animated
{
    if (CGRectIsEmpty(bounds)) {
        return nil;
    }

    if (!self.shapeLayer) {
        self.shapeLayer = [CAShapeLayer layer];
        animated = NO;
    }

    [CATransaction begin];
    [CATransaction setAnimationDuration:0];

    CGFloat xSpan = orientation == NUChartAxisOrientationX ?
    axis.range.span : orthogonalRange.span;

    CGFloat ySpan = orientation == NUChartAxisOrientationY ?
    axis.range.span : orthogonalRange.span;

    self.axisTransform = CGAffineTransformIdentity;

    CGFloat xScaleFactor = bounds.size.width / xSpan;
    CGFloat yScaleFactor = bounds.size.height / ySpan;

    if (orientation == NUChartAxisOrientationY) {
        CGFloat angle = orientation == NUChartAxisOrientationY ? M_PI_2 : 0;
        self.axisTransform = CGAffineTransformRotate(self.axisTransform, angle);
        self.axisTransform = CGAffineTransformScale(self.axisTransform, -1, 1);
        self.axisTransform = CGAffineTransformTranslate(self.axisTransform, -bounds.size.width, -bounds.size.height);
    }

    NUChartRange *xRange;
    NUChartRange *yRange;

    switch (orientation) {
        case NUChartAxisOrientationX:
            xRange = axis.range;
            yRange = orthogonalRange;
            break;
        default:
            yRange = axis.range;
            xRange = orthogonalRange;
            break;
    }

    if (self.displaysAxisLine) {
        CGPathRef path = [self newAxisLineForAxis:axis
                                  orthogonalRange:orthogonalRange
                                           bounds:bounds];

        CAShapeLayer *shape = [self.axisLineRenderer updatePath:path
                                                         bounds:bounds
                                                       animated:animated];
        if (self.lineLayer != shape) {
            [self.lineLayer removeFromSuperlayer];
            self.lineLayer = shape;
            [self.shapeLayer addSublayer:self.lineLayer];
        }
    }

    if (self.displaysAxisTicks) {
        CGPathRef path = [self newAxisTicksForAxis:axis
                                            bounds:bounds
                                      xScaleFactor:xScaleFactor
                                      yScaleFactor:yScaleFactor];

        CAShapeLayer *shape = [self.tickRenderer updatePath:path
                                                     bounds:bounds
                                                   animated:animated];
        if (self.ticksLayer != shape) {
            [self.ticksLayer removeFromSuperlayer];
            self.ticksLayer = shape;
            [self.shapeLayer addSublayer:self.ticksLayer];
        }
    }

    if (self.displaysAxisMajorLines) {
        CGPathRef path = [self newAxisMajorLinesForAxis:axis
                                        orthogonalRange:orthogonalRange
                                           xScaleFactor:animated ? self.oldXScaleFactor : xScaleFactor
                                           yScaleFactor:animated ? self.oldYScaleFactor : yScaleFactor];

        CAShapeLayer *shape = [self.majorLinesRenderer updatePath:path
                                                           bounds:bounds
                                                         animated:animated];
        if (self.majorLinesLayer != shape) {
            [self.majorLinesLayer removeFromSuperlayer];
            self.majorLinesLayer = shape;
            [self.shapeLayer addSublayer:self.majorLinesLayer];
        }
    }

    if (self.displaysAxisMinorLines) {
        CGPathRef path = [self newAxisMinorLinesForAxis:axis
                                        orthogonalRange:orthogonalRange
                                           xScaleFactor:animated ? self.oldXScaleFactor : xScaleFactor
                                           yScaleFactor:animated ? self.oldYScaleFactor : yScaleFactor];

        CAShapeLayer *shape = [self.minorLinesRenderer updatePath:path
                                                           bounds:bounds
                                                         animated:animated];

        if (self.minorLinesLayer != shape) {
            [self.minorLinesLayer removeFromSuperlayer];
            self.minorLinesLayer = shape;
            [self.shapeLayer addSublayer:self.minorLinesLayer];
        }
    }

    self.shapeLayer.affineTransform = self.axisTransform;

    [CATransaction commit];

    //Update ranges separately for animations to work
    if (animated) {
        CGPathRef majorPath = [self newAxisMajorLinesForAxis:axis
                                             orthogonalRange:orthogonalRange
                                                xScaleFactor:xScaleFactor
                                                yScaleFactor:yScaleFactor];

        [self.majorLinesRenderer updatePath:majorPath
                                     bounds:bounds
                                   animated:animated];

        CGPathRef minorPath = [self newAxisMinorLinesForAxis:axis
                                             orthogonalRange:orthogonalRange
                                                xScaleFactor:xScaleFactor
                                                yScaleFactor:yScaleFactor];

        [self.minorLinesRenderer updatePath:minorPath
                                     bounds:bounds
                                   animated:animated];

        CGPathRef ticksPath = [self newAxisMinorLinesForAxis:axis
                                             orthogonalRange:orthogonalRange
                                                xScaleFactor:xScaleFactor
                                                yScaleFactor:yScaleFactor];

        [self.minorLinesRenderer updatePath:ticksPath
                                     bounds:bounds
                                   animated:animated];
    }

    self.oldXScaleFactor = xScaleFactor;
    self.oldYScaleFactor = yScaleFactor;

    return self.shapeLayer;
}

- (CGFloat)requiredMargin
{
    CGFloat margin = self.axisLineRenderer.requiredMargin;
    margin = MAX(margin, self.tickRenderer.requiredMargin);
    margin = MAX(margin, self.minorLinesRenderer.requiredMargin);
    margin = MAX(margin, self.majorLinesRenderer.requiredMargin);

    return margin;
}

#pragma mark - Path creation

- (CGPathRef)newAxisLineForAxis:(NUChartAxis *)axis
                orthogonalRange:(NUChartRange *)orthogonalRange
                         bounds:(CGRect)bounds
{
    NSArray *orthogonal = @[@(self.intercept), @(self.intercept)];
    NSArray *parallel = @[@(axis.range.minimum), @(axis.range.maximum)];

    NUChartLinearInterpolator *interpolator = [NUChartLinearInterpolator new];
    NUChartData *data = [[NUChartData alloc] initWithxValues:parallel
                                                     yValues:orthogonal];
    return [interpolator newPathForData:data
                                 xRange:axis.range
                                 yRange:orthogonalRange
                                 bounds:bounds];
}

- (CGPathRef)newAxisTicksForAxis:(NUChartAxis *)axis
                          bounds:(CGRect)bounds
                    xScaleFactor:(CGFloat)xScaleFactor
                    yScaleFactor:(CGFloat)yScaleFactor
{
    return [self newVerticalLinesForAxis:axis
                               frequency:self.tickFrequency
                              lowerValue:self.intercept - self.tickHeight / 2.f
                              upperValue:self.intercept + self.tickHeight / 2.f
                            xScaleFactor:xScaleFactor
                            yScaleFactor:yScaleFactor];
}

- (CGPathRef)newAxisMajorLinesForAxis:(NUChartAxis *)axis
                      orthogonalRange:(NUChartRange *)orthogonalRange
                         xScaleFactor:(CGFloat)xScaleFactor
                         yScaleFactor:(CGFloat)yScaleFactor
{
    return [self newVerticalLinesForAxis:axis
                               frequency:self.majorLineFrequency
                              lowerValue:orthogonalRange.minimum
                              upperValue:orthogonalRange.maximum
                            xScaleFactor:xScaleFactor
                            yScaleFactor:yScaleFactor];
}

- (CGPathRef)newAxisMinorLinesForAxis:(NUChartAxis *)axis
                      orthogonalRange:(NUChartRange *)orthogonalRange
                         xScaleFactor:(CGFloat)xScaleFactor
                         yScaleFactor:(CGFloat)yScaleFactor
{
    return [self newVerticalLinesForAxis:axis
                               frequency:self.minorLineFrequency
                              lowerValue:orthogonalRange.minimum
                              upperValue:orthogonalRange.maximum
                            xScaleFactor:xScaleFactor
                            yScaleFactor:yScaleFactor];
}

#pragma mark - Helper

- (NSArray<NSNumber *>*)pointsInAxis:(NUChartAxis *)axis
                       withFrequency:(CGFloat)frequency
{
    NSMutableArray <NSNumber *>*points = [NSMutableArray new];

    NSUInteger numberOfPoints = ceil(axis.range.span / frequency);
    CGFloat spacing = axis.range.span / numberOfPoints;

    if (numberOfPoints <= 0) {
        return nil;
    }

    for (int i = 0; i <= numberOfPoints; i++) {
        [points addObject:@(spacing * i + axis.range.minimum)];
    }

    return points;
}

- (CGPathRef)newVerticalLinesForLowerPoints:(NSArray<NSValue *>*)lower
                                upperPoints:(NSArray<NSValue *>*)upper
                               xScaleFactor:(CGFloat)xScaleFactor
                               yScaleFactor:(CGFloat)yScaleFactor
{
    CGMutablePathRef result = CGPathCreateMutable();
    CGAffineTransform scale = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
    for (int i = 0; i < lower.count; i++) {
        CGPoint lowerPoint = lower[i].CGPointValue;
        CGPoint upperPoint = upper[i].CGPointValue;
        CGPathMoveToPoint(result, &scale, lowerPoint.x, lowerPoint.y);
        CGPathAddLineToPoint(result, &scale, upperPoint.x, upperPoint.y);
    }

    return CGPathRetain(result);
}

- (CGPathRef)newVerticalLinesForAxis:(NUChartAxis *)axis
                           frequency:(CGFloat)frequency
                          lowerValue:(CGFloat)lowerValue
                          upperValue:(CGFloat)upperValue
                        xScaleFactor:(CGFloat)xScaleFactor
                        yScaleFactor:(CGFloat)yScaleFactor
{
    NSArray <NSValue *>*reference = [self pointsInAxis:axis withFrequency:frequency];
    if (reference.count == 0) {
        return NULL;
    }

    NSMutableArray *lower = [[NSMutableArray alloc] initWithCapacity:reference.count];
    NSMutableArray *upper = [[NSMutableArray alloc] initWithCapacity:reference.count];

    for (int i = 0; i < reference.count; i++) {
        CGPoint referencePoint = reference[i].CGPointValue;
        [lower addObject:[NSValue valueWithCGPoint:CGPointMake(referencePoint.x, lowerValue)]];
        [upper addObject:[NSValue valueWithCGPoint:CGPointMake(referencePoint.x, upperValue)]];
    }

    return [self newVerticalLinesForLowerPoints:lower
                                    upperPoints:upper
                                   xScaleFactor:xScaleFactor
                                   yScaleFactor:yScaleFactor];
}

@end
