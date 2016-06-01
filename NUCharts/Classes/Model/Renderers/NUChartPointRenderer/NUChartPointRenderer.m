//
//  NUChartPointRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartPointRenderer.h"
#import "NUChartPointInterpolator.h"

@interface NUChartPointRenderer ()
@property (nonatomic, strong) NUChartPointInterpolator *interpolator;
@end

@implementation NUChartPointRenderer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _interpolator = [NUChartPointInterpolator new];
    self.diameter = 2.f;

    _strokeWidth = 1.f;
    _strokeColor = [UIColor blackColor];
}

- (CAShapeLayer *)drawData:(NUChartData *)data
                    xRange:(NSRange)xRange
                    yRange:(NSRange)yRange
                    bounds:(CGRect)bounds
{
    CGPathRef path = [self.interpolator pathForData:data
                                             xRange:xRange
                                             yRange:yRange
                                             bounds:bounds];

    CAShapeLayer *pointLayer = [self drawPath:path
                                   withxRange:xRange
                                       yRange:yRange
                                       bounds:bounds];

    pointLayer.fillColor = self.fillColor.CGColor;
    pointLayer.lineWidth = self.strokeWidth;
    pointLayer.strokeColor = self.strokeColor.CGColor;

    return pointLayer;
}


#pragma mark - Getter/setter

- (void)setDiameter:(CGFloat)diameter
{
    _diameter = diameter;
    self.interpolator.diameter = diameter;
}

@end
