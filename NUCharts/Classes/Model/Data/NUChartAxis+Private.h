//
//  NUChartAxis+Private.h
//  Pods
//
//  Created by Victor Maraccini on 6/12/16.
//
//

#import <NUCharts/NUCharts.h>

extern NSString *const kNUChartAxisRangeKey;

@interface NUChartAxis (Private)

- (void)updateRange:(NUChartRange *)range;

- (void)drawAxisForBounds:(CGRect)bounds
                 animated:(BOOL)animated;

@end
