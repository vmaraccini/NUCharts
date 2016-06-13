//
//  NUChartRenderReference.m
//  Pods
//
//  Created by Victor Maraccini on 6/13/16.
//
//

#import "NUChartRenderReference.h"
#import "NUChartAxis+Private.h"

@interface NUChartRenderReference()
@property (nonatomic, readwrite) CGRect bounds;
@end

@implementation NUChartRenderReference

- (instancetype)initWithxAxis:(NUChartAxis *)xAxis
                        yAxis:(NUChartAxis *)yAxis
                         data:(NUChartData *)data
                     renderer:(id<NUChartRenderer>)renderer
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
    return [self.renderer updateData:self.data
                              xRange:self.xAxis.range
                              yRange:self.yAxis.range
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
                                                    renderer:(id<NUChartRenderer>)renderer
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