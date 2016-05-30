//
//  NUChartView.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import "NUChartView.h"

@implementation NUChartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self drawChart];
}

#pragma mark - Private

- (void)initialize {
    self.chartRenderer = [NUChartRenderer new];

}

- (void)drawChart {
    CAShapeLayer *shapeLayer = [self.chartRenderer drawData:self.chartData
                                                     bounds:self.bounds];
    if (shapeLayer) {
        [self.layer addSublayer:shapeLayer];
    }
}

- (void)setChartData:(NUChartData *)chartData {
    _chartData = chartData;
    [self drawChart];
}

@end
