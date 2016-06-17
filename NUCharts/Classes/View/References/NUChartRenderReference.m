//
//  NUChartRenderReference.m
//  Pods
//
//  Created by Victor Maraccini on 6/13/16.
//
//

#import "NUChartRenderReference.h"
#import "NUChartRenderReference_Private.h"
#import "NUChartAxis+Private.h"

@interface NUChartRenderReference()
@property (nonatomic, readwrite) CGRect bounds;

@property (nonatomic, strong) CAShapeLayer *compositeLayer;

@property (nonatomic, weak) CAShapeLayer *dataLayer;
@property (nonatomic, weak) CAShapeLayer *xAxisLayer;
@property (nonatomic, weak) CAShapeLayer *yAxisLayer;
@end

@implementation NUChartRenderReference

- (instancetype)initWithxAxis:(NUChartAxis *)xAxis
                        yAxis:(NUChartAxis *)yAxis
                         data:(NUChartData *)data
                     renderer:(id<NUChartDataRenderer>)renderer
                       bounds:(CGRect)bounds
{
    self = [super init];
    if (self) {
        _xAxis = xAxis;
        _yAxis = yAxis;
        _data = data;
        _bounds = bounds;
        _renderer = renderer;

        [_xAxis addObserver:self
                 forKeyPath:kNUChartAxisRangeKey
                    options:0
                    context:NULL];
        [_yAxis addObserver:self
                 forKeyPath:kNUChartAxisRangeKey
                    options:0
                    context:NULL];
    }
    return self;
}

- (void)updateData:(NUChartData *)data
          animated:(BOOL)animated
{
    _data = data;
    [self drawAnimated:animated];
}

//Axis references are not changed so that linking can work.

- (void)updatexRange:(nullable NUChartRange *)xRange animated:(BOOL)animated
{
    if (!xRange) {
        xRange = [NUChartRange fullXRangeForData:self.data];
    }
    [self.xAxis updateRange:xRange];
    [self drawAnimated:animated];
}

- (void)updateyRange:(nullable NUChartRange *)yRange animated:(BOOL)animated
{
    if (!yRange) {
        yRange = [NUChartRange fullYRangeForData:self.data];
    }
    [self.yAxis updateRange:yRange];
    [self drawAnimated:animated];
}

- (void)fitAxisAnimated:(BOOL)animated
{
    [self updatexRange:nil animated:animated];
    [self updateyRange:nil animated:animated];
}

- (CAShapeLayer *)drawAnimated:(BOOL)animated
{
    if (!self.compositeLayer) {
        return [self createCompositeLayer];
    }

    CAShapeLayer *dataLayer = [self.renderer updateData:self.data
                                                 xRange:self.xAxis.range
                                                 yRange:self.yAxis.range
                                                 bounds:self.bounds
                                               animated:animated];

    CAShapeLayer *xAxisLayer = [self drawxAxisAnimated:animated];
    CAShapeLayer *yAxisLayer = [self drawyAxisAnimated:animated];

    if ((self.xAxisLayer != xAxisLayer) && xAxisLayer) {
        [self.xAxisLayer removeFromSuperlayer];
        [self.compositeLayer addSublayer:xAxisLayer];
        self.xAxisLayer = xAxisLayer;
    }

    if ((self.yAxisLayer != yAxisLayer) && yAxisLayer) {
        [self.yAxisLayer removeFromSuperlayer];
        [self.compositeLayer addSublayer:yAxisLayer];
        self.yAxisLayer = yAxisLayer;
    }

    if (self.dataLayer != dataLayer && dataLayer) {
        [self.dataLayer removeFromSuperlayer];
        [self.compositeLayer addSublayer:dataLayer];
        self.dataLayer = dataLayer;
    }

    return self.compositeLayer;
}

- (CAShapeLayer *)createCompositeLayer
{
    self.compositeLayer = [CAShapeLayer layer];

    //Axes
    CAShapeLayer *xAxisLayer = [self drawxAxisAnimated:NO];
    if (xAxisLayer) {
        [self.compositeLayer addSublayer:xAxisLayer];
    }

    CAShapeLayer *yAxisLayer = [self drawyAxisAnimated:NO];
    if (yAxisLayer) {
        [self.compositeLayer addSublayer:yAxisLayer];
    }

    [self.compositeLayer addSublayer:[self.renderer updateData:self.data
                                                        xRange:self.xAxis.range
                                                        yRange:self.yAxis.range
                                                        bounds:self.bounds
                                                      animated:NO]];

    return self.compositeLayer;
}

- (CAShapeLayer *)drawxAxisAnimated:(BOOL)animated
{
    return [self.xAxis.renderer updateAxis:self.xAxis
                           orthogonalRange:self.yAxis.range
                               orientation:NUChartAxisOrientationX
                                    bounds:self.bounds
                                  animated:animated];
}

- (CAShapeLayer *)drawyAxisAnimated:(BOOL)animated
{
    return [self.yAxis.renderer updateAxis:self.yAxis
                           orthogonalRange:self.yAxis.range
                               orientation:NUChartAxisOrientationY
                                    bounds:self.bounds
                                  animated:animated];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:kNUChartAxisRangeKey]) {
        [self drawAnimated:YES];
    }
}

- (void)dealloc
{
    @try {
        [self.xAxis removeObserver:self forKeyPath:kNUChartAxisRangeKey];
        [self.yAxis removeObserver:self forKeyPath:kNUChartAxisRangeKey];
    } @catch (NSException *exception) { }
}

@end

@implementation NUChartLineRenderReference
@dynamic renderer;
@end

@implementation NUChartPointRenderReference
@dynamic renderer;
@end

@implementation NUChartRenderReferenceFactory

+ (__kindof NUChartRenderReference *)renderReferenceForxAxis:(NUChartAxis *)xAxis
                                                       yAxis:(NUChartAxis *)yAxis
                                                        data:(NUChartData *)data
                                                    renderer:(id<NUChartDataRenderer>)renderer
                                                      bounds:(CGRect)bounds
{
    if ([renderer isKindOfClass:[NUChartLineRenderer class]]) {
        return [[NUChartLineRenderReference alloc] initWithxAxis:xAxis
                                                           yAxis:yAxis
                                                            data:data
                                                        renderer:renderer
                                                          bounds:bounds];
    }
    if ([renderer isKindOfClass:[NUChartPointRenderer class]]) {
        return [[NUChartPointRenderReference alloc] initWithxAxis:xAxis
                                                            yAxis:yAxis
                                                             data:data
                                                         renderer:renderer
                                                           bounds:bounds];
    }

    return [[NUChartRenderReference alloc] initWithxAxis:xAxis
                                                   yAxis:yAxis
                                                    data:data
                                                renderer:renderer
                                                  bounds:bounds];
}

@end