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

//Line properties

///The color of the stroke (line)
@property (nonatomic, strong) UIColor *strokeColor;
///Gets/sets the percentage (from 0 to 1) of the line drawn onscreen. Animatable.
@property (nonatomic, readwrite) CGFloat strokeEnd;
///The width of the line
@property (nonatomic, readwrite) CGFloat lineWidth;

//https://developer.apple.com/library/ios/documentation/GraphicsImaging/Reference/CAShapeLayer_class/#//apple_ref/occ/instp/CAShapeLayer/lineDashPattern
/**
 The dash pattern
 Takes an array of NSNumber objects specifying the lengths of the painted segments and unpainted segments, respectively.
 @remarks Uses CAShapeLayer's lineDashPattern property.
 **/
@property (nonatomic, readwrite) NSArray<NSNumber *>* dashPattern;
///The phase of the line dash. Value is in pixels.
///@remarks Uses CAShapeLayer's lineDashPhase property.
@property (nonatomic, readwrite) CGFloat dashPhase;

- (void)setStrokeEnd:(CGFloat)strokeEnd animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
