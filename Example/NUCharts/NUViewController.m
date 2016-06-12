//
//  NUViewController.m
//  NUCharts
//
//  Created by Victor on 05/29/2016.
//  Copyright (c) 2016 Victor. All rights reserved.
//

#import "NUViewController.h"

#import <NUCharts/NUCharts.h>
#import <Masonry/Masonry.h>
#import <NUAnimationKit/NUAnimationController.h>

@interface NUViewController ()
@property (nonatomic, strong) NUChartView *chartView;

@property (nonatomic, strong) NUChartData *bezierData;

@property (nonatomic, strong) NUChartRenderStructure *bezierStruct;
@property (nonatomic, strong) NUChartRenderStructure *startPointStruct;
@property (nonatomic, strong) NUChartRenderStructure *endPointStruct;

@property (nonatomic, strong) NUAnimationController *animator;
@end

@implementation NUViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self createChart];
    [self createButton];

    [self setupAnimations];
}

#pragma mark - Setup

- (void)setupAnimations {
    NUChartPointRenderer *startPointRenderer = (NUChartPointRenderer *)self.startPointStruct.renderer;
    NUChartPointRenderer *endPointRenderer = (NUChartPointRenderer *)self.endPointStruct.renderer;
    NUChartLineRenderer *lineRenderer = (NUChartLineRenderer *)self.bezierStruct.renderer;

    NUChartRenderStructure *bezierStructure = self.bezierStruct;
    NUChartRenderStructure *pointStructure = self.startPointStruct;

    NUChartData *defaultData = self.bezierData;
    NUChartData *newData = [[NUChartData alloc] initWithxValues:@[@(0),@(50),@(100),@(150)]
                                                        yValues:@[@(100),@(100),@(0),@(100)]];

    NUChartData *defaultPointData = [[NUChartData alloc] initWithxValues:@[@0]
                                                                 yValues:@[@0]];
    NUChartData *newPointData = [[NUChartData alloc] initWithxValues:@[@0]
                                                             yValues:@[@100]];

    self.animator = [NUAnimationController new];

    self.animator.initializationBlock = ^{
        startPointRenderer.diameter = 1e-3;
        endPointRenderer.diameter = 1e-3;
        [lineRenderer setStrokeEnd:0.f animated:NO];
        [bezierStructure updateData:defaultData animated:NO];
        [pointStructure updateData:defaultPointData animated:NO];
        [bezierStructure fitAxisAnimated:NO];
    };

    [self.animator addAnimations:^{
        startPointRenderer.diameter = 8;
    }].withDuration(0.3)
    .withCurve(UIViewAnimationCurveEaseOut);

    [self.animator addAnimations:^{
        lineRenderer.strokeEnd = 1.f;
    }]
    .withDuration(0.75)
    .withCurve(UIViewAnimationCurveEaseOut);

    [self.animator addAnimations:^{
        endPointRenderer.diameter = 8;
    }].withDuration(0.15);

    [self.animator addAnimations:^{
        [bezierStructure updateData:newData animated:YES];
        [pointStructure updateData:newPointData animated:YES];
    }];

    [self.animator addAnimations:^{
        [bezierStructure updatexAxis:[[NUChartAxis alloc] initWithRange:NUMakeRange(0,200)]
                            animated:YES];
    }];

    self.animator.initializationBlock();
}

- (void)startAnimation {
    [self.animator startAnimationChain];
}

- (void)createButton {
    UIButton *startButton = [UIButton new];
    [startButton setTitle:@"Start" forState:UIControlStateNormal];
    [startButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [startButton addTarget:self
                    action:@selector(startAnimation)
          forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];

    [startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).offset(-100);
        make.centerX.equalTo(self.view);
    }];
}

- (void)createChart {
    self.chartView = [NUChartView new];
    [self.view addSubview:self.chartView];

    self.bezierStruct = [self addBezierCurve:self.chartView];
    [self addAverageLine:self.chartView atSameAxisAs:self.bezierStruct];
    self.startPointStruct = [self addStartPoint:self.chartView
                                   atSameAxisAs:self.bezierStruct];
    self.endPointStruct = [self addEndPoint:self.chartView
                               atSameAxisAs:self.bezierStruct];

    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(200);
    }];
}

#pragma mark - Curve creation

- (NUChartRenderStructure *)addBezierCurve:(NUChartView *)view
{
    self.bezierData = [[NUChartData alloc] initWithxValues:@[@(0),@(50),@(100),@(150)]
                                                   yValues:@[@(0),@(100),@(0),@(100)]];

    NUChartLineRenderer *renderer = [NUChartLineRenderer new];
    renderer.lineWidth = 2;
    renderer.interpolator = [NUChartFlatYBezierInterpolator new];

    return [view addDataSet:self.bezierData
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
    renderer.strokeColor = [UIColor redColor];
    return [view addDataSet:average
               withRenderer:renderer
                    toAxisX:sibling.xAxis
                      axisY:sibling.yAxis];
}

- (NUChartRenderStructure *)addStartPoint:(NUChartView *)view
                             atSameAxisAs:(NUChartRenderStructure *)sibling
{
    NUChartData *points = [[NUChartData alloc] initWithxValues:@[@(0)]
                                                       yValues:@[@(0)]];

    NUChartPointRenderer *renderer = [NUChartPointRenderer new];
    renderer.diameter = 8;
    renderer.fillColor = [UIColor blueColor];
    return [view addDataSet:points
               withRenderer:renderer
                    toAxisX:sibling.xAxis
                      axisY:sibling.yAxis];
}

- (NUChartRenderStructure *)addEndPoint:(NUChartView *)view
                           atSameAxisAs:(NUChartRenderStructure *)sibling
{
    NUChartData *points = [[NUChartData alloc] initWithxValues:@[@(150)]
                                                       yValues:@[@(100)]];

    NUChartPointRenderer *renderer = [NUChartPointRenderer new];
    renderer.diameter = 8;
    renderer.fillColor = [UIColor blueColor];
    return [view addDataSet:points
               withRenderer:renderer
                    toAxisX:sibling.xAxis
                      axisY:sibling.yAxis];
}


@end
