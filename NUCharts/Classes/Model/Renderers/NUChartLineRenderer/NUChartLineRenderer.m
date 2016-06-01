//
//  NUChartRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartLineRenderer.h"

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

- (CAShapeLayer *)drawData:(NUChartData *)data
                    xRange:(NSRange)xRange
                    yRange:(NSRange)yRange
                    bounds:(CGRect)bounds
{
    CGPathRef path = [self.interpolator pathForData:data
                                             xRange:xRange
                                             yRange:yRange
                                             bounds:bounds];
    
    CAShapeLayer *shape = [self drawPath:path
                              withxRange:xRange
                                  yRange:yRange
                                  bounds:bounds];

    shape.lineDashPattern = self.dashPattern;
    shape.lineDashPhase = self.dashPhase;
    shape.strokeColor = self.strokeColor.CGColor;
    shape.lineWidth = self.lineWidth;
    shape.fillColor = [UIColor clearColor].CGColor;

    return shape;
}

#pragma mark - Private

- (void)initialize
{
    _strokeColor = [UIColor blackColor];
    _lineWidth = 1.f;
}

@end