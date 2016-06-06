//
//  NUChartView.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import "NUChartView.h"

@implementation NUChartRenderStructure

- (instancetype)initWithxAxis:(NUChartAxis *)xAxis
                        yAxis:(NUChartAxis *)yAxis
                         data:(NUChartData *)data
                     renderer:(id<NUChartRenderer>)renderer
{
    self = [super init];
    if (self) {
        _xAxis = xAxis;
        _yAxis = yAxis;
        _data = data;
        _renderer = renderer;
    }
    return self;
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
    [self drawChart];
}

-(NUChartRenderStructure *)addDataSet:(NUChartData *)data
                         withRenderer:(id<NUChartRenderer>)renderer {
    NSRange xRange = NSMakeRange(data.minimumX, data.maximumX - data.minimumX);
    NSRange yRange = NSMakeRange(data.minimumY, data.maximumY - data.minimumY);
    return [self addDataSet:data
               withRenderer:renderer
                    toAxisX:[[NUChartAxis alloc] initWithRange:xRange]
                      axisY:[[NUChartAxis alloc] initWithRange:yRange]];
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
                                         renderer:renderer];
    [self.renderStructures addObject:structure];
    [self layoutSubviews];
    return structure;
}

- (void)removeChartByReference:(NUChartRenderStructure *)structure {
    [self.renderStructures removeObject:structure];
    [self layoutSubviews];
}

#pragma mark - Private

- (void)drawChart {
    
    //Remove existing layers
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    [self.renderStructures enumerateObjectsUsingBlock:^(NUChartRenderStructure * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *shapeLayer = [obj.renderer drawData:obj.data
                                                   xRange:obj.xAxis.range
                                                   yRange:obj.yAxis.range
                                                   bounds:self.bounds];
        if (shapeLayer) {
            [self.layer addSublayer:shapeLayer];
        }
    }];
}

@end
