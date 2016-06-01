//
//  NUChartAxis.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartAxis.h"

@implementation NUChartAxis

- (instancetype)initWithRange:(NSRange)range
{
    self = [self init];
    if (self) {
        _range = range;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _range = NSMakeRange(NSNotFound, NSNotFound);
    }
    return self;
}

@end