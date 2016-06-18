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
    return [self.interpolator newPathForData:data
                                      xRange:xRange
                                      yRange:yRange
                                      bounds:bounds];
}

- (nullable CAShapeLayer *)drawPath:(CGPathRef)path
                             bounds:(CGRect)bounds
{
    [super drawPath:path
             bounds:bounds];

    self.shapeLayer.lineDashPattern = self.dashPattern;
    self.shapeLayer.lineDashPhase = self.dashPhase;
    self.shapeLayer.strokeColor = self.strokeColor.CGColor;
    self.shapeLayer.lineWidth = self.lineWidth;
    self.shapeLayer.fillColor = [UIColor clearColor].CGColor;

    self.shapeLayer.strokeEnd = self.strokeEnd;

    [super willUpdate];

    return self.shapeLayer;
}

- (CGFloat)requiredMargin
{
    return self.lineWidth / 2.f;
}

#pragma mark - Getter/setter

- (void)setShapeLayer:(CAShapeLayer *)shapeLayer
{
    [super setShapeLayer:shapeLayer];
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
    [super willUpdate];
    if (!animated) {
        [CATransaction commit];
    }
}

- (void)setStrokeColor:(UIColor *)strokeColor
{
    _strokeColor = strokeColor;
    self.shapeLayer.strokeColor = strokeColor.CGColor;
    [super willUpdate];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    self.shapeLayer.lineWidth = lineWidth;
    [super willUpdate];
}

- (void)setDashPattern:(NSArray<NSNumber *> *)dashPattern
{
    _dashPattern = dashPattern;
    self.shapeLayer.lineDashPattern = dashPattern;
    [super willUpdate];
}

- (void)setDashPhase:(CGFloat)dashPhase
{
    _dashPhase = dashPhase;
    self.shapeLayer.lineDashPhase = dashPhase;
    [super willUpdate];
}

#pragma mark - Private

- (void)initialize
{
    _strokeColor = [UIColor blackColor];
    _strokeEnd = 1.f;
    _lineWidth = 1.f;
}

@end