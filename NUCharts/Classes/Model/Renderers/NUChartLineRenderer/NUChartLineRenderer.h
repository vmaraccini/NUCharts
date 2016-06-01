//
//  NUChartRenderer.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartProtocols.h"
#import "NUChartData.h"
#import "NUChartBaseRenderer.h"
#import "NUChartLinearInterpolator.h"

NS_ASSUME_NONNULL_BEGIN

@interface NUChartLineRenderer : NUChartBaseRenderer

- (instancetype)initWithInterpolator:(id<NUChartInterpolator>)interpolator NS_DESIGNATED_INITIALIZER;

@property (nonatomic, strong) id<NUChartInterpolator> interpolator;

@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, readwrite) CGFloat lineWidth;

@property (nonatomic, readwrite) NSArray<NSNumber *>* dashPattern;
@property (nonatomic, readwrite) CGFloat dashPhase;

@end

NS_ASSUME_NONNULL_END