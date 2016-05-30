//
//  NUChartData.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartData.h"

@implementation NUChartData
- (instancetype)initWithxValues:(NSArray<NSNumber *>*)xValues
                        yValues:(NSArray<NSNumber *>*)yValues {
    self = [super init];
    if (self) {
        _xValues = xValues;
        _yValues = yValues;
    }
    return self;
}
@end
