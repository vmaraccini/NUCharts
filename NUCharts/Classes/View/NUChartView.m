//
//  NUChartView.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import "NUChartView.h"
#import "NUChartRenderReference_Private.h"

@interface NUChartView ()
@property (nonatomic, strong) NSMutableArray<NUChartRenderReference *>*renderStructures;
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

    for (NUChartRenderReference *reference in self.renderStructures) {
        [reference setBounds:bounds];
    }

    [self drawChart];
}

-(__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                  withRenderer:(id<NUChartRenderer>)renderer {
    return [self addDataSet:data
               withRenderer:renderer
                    toAxisX:[[NUChartAxis alloc] initWithRange:[NUChartRange fullXRangeForData:data]]
                      axisY:[[NUChartAxis alloc] initWithRange:[NUChartRange fullYRangeForData:data]]];
}

- (__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                   withRenderer:(id<NUChartRenderer>)renderer
                                        toAxisX:(nonnull NUChartAxis *)xAxis
                                          axisY:(nonnull NUChartAxis *)yAxis
{

    NUChartRenderReference *reference =
    [NUChartRenderReferenceFactory renderReferenceForxAxis:xAxis
                                                     yAxis:yAxis
                                                      data:data
                                                  renderer:renderer
                                                    bounds:self.bounds];

    [self.renderStructures addObject:reference];
    [self drawChart];
    return reference;
}

- (void)removeChartByReference:(__kindof NUChartRenderReference *)structure {
    [self.renderStructures removeObject:structure];
    [self drawChart];
}

- (CGRect)rectForReference:(NUChartRenderReference *)reference
{
    return [self convertRect:[reference.renderer rectForData] toView:self.superview];
}

#pragma mark - Private

- (void)drawChart {

    //Remove existing layers
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    [self.renderStructures enumerateObjectsUsingBlock:^(NUChartRenderReference * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CAShapeLayer *shapeLayer = [obj drawAnimated:YES];
        if (shapeLayer) {
            [self.layer addSublayer:shapeLayer];
        }
    }];
}

@end
