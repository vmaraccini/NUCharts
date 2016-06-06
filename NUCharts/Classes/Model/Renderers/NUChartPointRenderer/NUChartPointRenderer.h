//
//  NUChartPointRenderer.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import <Foundation/Foundation.h>
#import "NUChartBaseRenderer.h"
#import "NUChartProtocols.h"

@interface NUChartPointRenderer : NUChartBaseRenderer

///The diameter of the points. Animatable.
@property (nonatomic, readwrite) CGFloat diameter;
///The width of the point stroke (border)
@property (nonatomic, readwrite) CGFloat strokeWidth;
///The color of the point stroke (border)
@property (nonatomic, strong) UIColor *strokeColor;
///The point's fill color
@property (nonatomic, strong) UIColor *fillColor;

- (void)setDiameter:(CGFloat)diameter animated:(BOOL)animated;

///The animation duration. Defaults to 0.5 s
@property (nonatomic, readwrite) CGFloat animationDuration;

///The animation timing function. Defaults to kCAMediaTimingFunctionEaseInEaseOut
@property (nonatomic, readwrite) CAMediaTimingFunction *animationTimingFunction;

///Fades the points in.
- (void)animateFade;
///Animates the points from a small to a large scale.
- (void)animateScale;

@end
