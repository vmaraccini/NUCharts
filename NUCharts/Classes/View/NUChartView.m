//
//  NUChartView.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import "NUChartView.h"

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

- (void)updatexAxis:(NUChartAxis *)xAxis animated:(BOOL)animated
{
    if (!xAxis) {
        xAxis = [NUChartAxis fullXRangeForData:self.data];
    }
    _xAxis = xAxis;
    [self drawAnimated:animated];
}

- (void)updateyAxis:(NUChartAxis *)yAxis animated:(BOOL)animated
{
    if (!yAxis) {
        yAxis = [NUChartAxis fullYRangeForData:self.data];
    }
    _yAxis = yAxis;
    [self drawAnimated:animated];
}

- (void)fitAxisAnimated:(BOOL)animated
{
    [self updatexAxis:nil animated:animated];
    [self updateyAxis:nil animated:animated];
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
                    toAxisX:[NUChartAxis fullXRangeForData:data]
                      axisY:[NUChartAxis fullYRangeForData:data]];
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
