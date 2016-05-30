//
//  NUChartProtocols.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartData.h"

NS_ASSUME_NONNULL_BEGIN

// Interpolator

@protocol NUChartInterpolator <NSObject>
- (CGPathRef)pathForData:(NUChartData *)data CF_RETURNS_RETAINED;
@end

// Renderer

@protocol NUChartRenderer <NSObject>
@property (nonatomic, strong) id<NUChartInterpolator> interpolator;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, readwrite) CGFloat lineWidth;

- (CAShapeLayer *__nullable)drawData:(NUChartData *)data
                              bounds:(CGRect)bounds;
@end

NS_ASSUME_NONNULL_END
