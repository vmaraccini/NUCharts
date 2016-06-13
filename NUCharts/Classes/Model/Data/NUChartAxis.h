//
//  NUChartAxis.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartData.h"

NS_ASSUME_NONNULL_BEGIN

#define NUMakeRange(min, max) [[NUChartRange alloc] initWithMinimum:min maximum:max]

@interface NUChartRange : NSObject

@property (nonatomic, readonly) CGFloat minimum;
@property (nonatomic, readonly) CGFloat maximum;

@property (nonatomic, readonly) CGFloat span;

- (instancetype)initWithMinimum:(CGFloat)min
                        maximum:(CGFloat)maximum;

- (BOOL)isWithinRange:(CGFloat)value;

- (BOOL)isEmpty;

+ (instancetype)fullXRangeForData:(NUChartData *)data;
+ (instancetype)fullYRangeForData:(NUChartData *)data;

@end

@interface NUChartAxis : NSObject
@property (nonatomic, readonly) NUChartRange *range;

- (instancetype)initWithRange:(NUChartRange *)range;

@end

NS_ASSUME_NONNULL_END
