//
//  NUChartAxis.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartAxis.h"

@implementation NUChartRange

- (instancetype)init
{
    self = [super init];
    if (self) {
        _minimum = NAN;
        _maximum = NAN;
        _span = NAN;
    }
    return self;
}

- (instancetype)initWithMinimum:(CGFloat)minimum
                        maximum:(CGFloat)maximum
{
    self = [super init];
    if (self) {
        _minimum = minimum;
        _maximum = maximum;
        _span = maximum - minimum;
    }
    return self;
}

- (BOOL)isEmpty
{
    //Tests if span is NAN. Trivia: NAN != NAN.
    return self.span != self.span;
}

- (BOOL)isWithinRange:(CGFloat)value
{
    return value >= _minimum &&
    value <= _maximum;
}

@end

@implementation NUChartAxis

- (instancetype)initWithRange:(NUChartRange *)range
{
    self = [super init];
    if (self) {
        _range = range;
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _range = [NUChartRange new];
    }
    return self;
}

@end