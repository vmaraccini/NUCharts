//
//  NUViewController.m
//  NUCharts
//
//  Created by Victor on 05/29/2016.
//  Copyright (c) 2016 Victor. All rights reserved.
//

#import "NUViewController.h"

#import <NUCharts/NUChart.h>
#import <Masonry/Masonry.h>

@interface NUViewController ()

@end

@implementation NUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NUChartView *view = [NUChartView new];

    NUChartRenderStructure *bezierStruct = [self addBezierCurve:view];
    [self addAverageLine:view
            atSameAxisAs:bezierStruct];
    [self addPoints:view];

    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(200);
    }];

}

- (NUChartRenderStructure *)addBezierCurve:(NUChartView *)view
{
    NUChartData *data = [[NUChartData alloc] initWithxValues:@[@(0),@(50),@(100),@(150)]
                                                     yValues:@[@(0),@(100),@(0),@(100)]];

    NUChartLineRenderer *renderer = [NUChartLineRenderer new];
    renderer.lineWidth = 2;
    renderer.interpolator = [NUChartFlatYBezierInterpolator new];
    return [view addDataSet:data
               withRenderer:renderer];
}

- (NUChartRenderStructure *)addAverageLine:(NUChartView *)view
                              atSameAxisAs:(NUChartRenderStructure *)sibling
{
    NUChartData *average = [[NUChartData alloc] initWithxValues:@[@(0),@(150)]
                                                        yValues:@[@(50),@(50)]];

    NUChartLineRenderer *renderer = [NUChartLineRenderer new];
    renderer.lineWidth = 1;
    renderer.dashPattern = @[@2, @5];
    return [view addDataSet:average
               withRenderer:renderer
                    toAxisX:sibling.xAxis
                      axisY:sibling.yAxis];
}

- (NUChartRenderStructure *)addPoints:(NUChartView *)view
{
    NUChartData *points = [[NUChartData alloc] initWithxValues:@[@(0),@(150)]
                                                       yValues:@[@(0),@(100)]];

    NUChartPointRenderer *renderer = [NUChartPointRenderer new];
    renderer.diameter = 8;
    renderer.fillColor = [UIColor blueColor];
    return [view addDataSet:points
               withRenderer:renderer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
