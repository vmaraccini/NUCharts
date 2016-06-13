//
//  NUChartView.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import "NUChartView.h"
#import "NUChartAxis+Private.h"

@interface NUChartRenderStructure()
@property (nonatomic, readwrite) CGRect bounds;
@end

@implementation NUChartRenderStructure

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

@end

@interface NUChartView ()
@property (nonatomic, strong) NSMutableArray<NUChartRenderStructure *>*renderStructures;
@end

@implementation NUChartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _renderStructures = [NSMutableArray new];
    }
    return self;
}

- (void)setBounds:(CGRect)bounds {
    [super setBounds:bounds];

    for (NUChartRenderStructure *structure in self.renderStructures) {
        [structure setBounds:bounds];
    }

    [self drawChart];
}

-(NUChartRenderStructure *)addDataSet:(NUChartData *)data
                         withRenderer:(id<NUChartRenderer>)renderer {
    return [self addDataSet:data
               withRenderer:renderer
                    toAxisX:[[NUChartAxis alloc] initWithRange:[NUChartRange fullXRangeForData:data]]
                      axisY:[[NUChartAxis alloc] initWithRange:[NUChartRange fullYRangeForData:data]]];
}

- (NUChartRenderStructure *)addDataSet:(NUChartData *)data
                          withRenderer:(id<NUChartRenderer>)renderer
                               toAxisX:(nonnull NUChartAxis *)xAxis
                                 axisY:(nonnull NUChartAxis *)yAxis
{
    NUChartRenderStructure *structure =
    [[NUChartRenderStructure alloc] initWithxAxis:xAxis
                                            yAxis:yAxis
                                             data:data
                                         renderer:renderer
                                           bounds:self.bounds];
    [self.renderStructures addObject:structure];
    [self drawChart];
    return structure;
}

- (void)removeChartByReference:(NUChartRenderStructure *)structure {
    [self.renderStructures removeObject:structure];
    [self drawChart];
}

#pragma mark - Private

- (void)drawChart {

    //Remove existing layers
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    [self.renderStructures enumerateObjectsUsingBlock:^(NUChartRenderStructure * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *shapeLayer = [obj drawAnimated:YES];
        if (shapeLayer) {
            [self.layer addSublayer:shapeLayer];
        }
    }];
}

@end
