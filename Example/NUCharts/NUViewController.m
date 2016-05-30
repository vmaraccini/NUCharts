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
    view.chartRenderer.interpolator = [NUChartFlatYBezierInterpolator new];
    view.chartData = [[NUChartData alloc] initWithxValues:@[@(0),@(50),@(100),@(150)]
                                                  yValues:@[@(0),@(100),@(0),@(100)]];


    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(200);
    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
