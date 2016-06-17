//
//  NUTableViewController.m
//  NUCharts
//
//  Created by Victor Maraccini on 6/17/16.
//  Copyright © 2016 Nubank. All rights reserved.
//

#import "NUTableViewController.h"
#import "NUAnimatedChartViewController.h"

typedef NS_ENUM(NSUInteger, NUChartCell) {
    NUChartCellSimple,
    NUChartCellAnimated,
    NUChartCellAxes
};

@interface NUTableViewController ()
@property (nonatomic, strong) NSArray *titles;
@end

@implementation NUTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _titles = @[@"Basic chart", @"Animated chart", @"Chart with axes"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == NUChartCellSimple) {
        NUAnimatedChartViewController *vc = [NUAnimatedChartViewController new];
        [self.navigationController pushViewController:vc
                                             animated:YES];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

@end
