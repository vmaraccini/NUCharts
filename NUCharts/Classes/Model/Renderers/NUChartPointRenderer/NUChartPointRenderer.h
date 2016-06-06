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

@property (nonatomic, readwrite) CGFloat diameter;
@property (nonatomic, readwrite) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

- (void)setDiameter:(CGFloat)diameter animated:(BOOL)animated;

///The animation duration. Defaults to 0.5 s
@property (nonatomic, readwrite) CGFloat animationDuration;

///The animation timing function. Defaults to kCAMediaTimingFunctionEaseInEaseOut
@property (nonatomic, readwrite) CAMediaTimingFunction *animationTimingFunction;

- (void)animateFade;
- (void)animateScale;

@end
