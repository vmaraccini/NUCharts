//
//  NUChartRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartLineRenderer.h"

@interface NUChartLineRenderer ()

@end

@implementation NUChartLineRenderer

- (instancetype)initWithInterpolator:(id<NUChartInterpolator>)interpolator
{
    self = [super init];
    if (self) {
        self.interpolator = interpolator;
        [self initialize];
    }
    return self;
}

- (instancetype)init
{
    id defaultInterpolator = [NUChartLinearInterpolator new];
    return [self initWithInterpolator:defaultInterpolator];
}

#pragma mark - Public

- (CGPathRef)pathForData:(NUChartData*)data
              withxRange:(NUChartRange *)xRange
                  yRange:(NUChartRange *)yRange
                  bounds:(CGRect)bounds
{
    return [self.interpolator pathForData:data
                                   xRange:xRange
                                   yRange:yRange
                                   bounds:bounds];
}

- (CAShapeLayer *)drawData:(NUChartData *)data
                    xRange:(NUChartRange *)xRange
                    yRange:(NUChartRange *)yRange
                    bounds:(CGRect)bounds
{
    [super drawData:data
             xRange:xRange
             yRange:yRange
             bounds:bounds];

    self.shapeLayer.lineDashPattern = self.dashPattern;
    self.shapeLayer.lineDashPhase = self.dashPhase;
    self.shapeLayer.strokeColor = self.strokeColor.CGColor;
    self.shapeLayer.lineWidth = self.lineWidth;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;

    self.shapeLayer.strokeEnd = self.strokeEnd;

    self.shapeLayer.delegate = self;

    return self.shapeLayer;
}

- (void)setStrokeEnd:(CGFloat)strokeEnd {
    [self setStrokeEnd:strokeEnd animated:YES];
}

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated {
    if (!animated) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0];
    }
    _strokeEnd = strokeEnd;
    self.shapeLayer.strokeEnd = strokeEnd;
    if (!animated) {
        [CATransaction commit];
    }
}

#pragma mark - Animations

//- (void)animateBuildX
//{
//    [self.interpolator animateBuildX];
//}
//- (void)animateBuildY
//{
//    [self.interpolator animateBuildY];
//}
//- (void)animateBuildXY
//{
//    [self.interpolator animateBuildX];
//    [self.interpolator animateBuildY];
//}

#pragma mark - Private

- (void)initialize
{
    _strokeColor = [UIColor blackColor];
    _strokeEnd = 1.f;
    _lineWidth = 1.f;
}

@end