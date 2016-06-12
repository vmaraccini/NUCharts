//
//  NUChartPointRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartPointRenderer.h"
#import "NUChartPointInterpolator.h"

@interface NUChartPointRenderer ()

@property (nonatomic, strong) NUChartData *data;
@property (nonatomic) NUChartRange *xRange;
@property (nonatomic) NUChartRange *yRange;
@property (nonatomic) CGRect bounds;

@property (nonatomic, strong) NUChartPointInterpolator *interpolator;
@property (nonatomic, strong) CAShapeLayer *layer;
@end

@implementation NUChartPointRenderer

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _interpolator = [NUChartPointInterpolator new];
    _animationDuration = 0.5;
    _animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    _strokeWidth = 1.f;
    _strokeColor = [UIColor blackColor];

    self.diameter = 2.f;
}

- (CAShapeLayer *)drawData:(NUChartData *)data
                    xRange:(NUChartRange *)xRange
                    yRange:(NUChartRange *)yRange
                    bounds:(CGRect)bounds
{
    _data = data;
    _xRange = xRange;
    _yRange = yRange;
    _bounds = bounds;

    CGPathRef path = [self.interpolator pathForData:data
                                             xRange:xRange
                                             yRange:yRange
                                             bounds:bounds];

    self.layer = [self drawPath:path
                     withxRange:xRange
                         yRange:yRange
                         bounds:bounds];
    self.layer.delegate = self;

    self.layer.fillColor = self.fillColor.CGColor;
    self.layer.lineWidth = self.strokeWidth;
    self.layer.strokeColor = self.strokeColor.CGColor;

    return self.layer;
}

- (void)updatePath {
    self.layer.path = [self.interpolator pathForData:self.data
                                              xRange:self.xRange
                                              yRange:self.yRange
                                              bounds:self.bounds];
}

-(id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    if ([event isEqualToString:@"path"]) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:event];
        animation.fromValue = (__bridge id _Nullable)(self.layer.path);
        return animation;
    }
    return nil;
}

#pragma mark - Animations

- (void)animateFade {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(0.f);
    animation.toValue = @(1.f);
    animation.duration = self.animationDuration;
    animation.timingFunction = self.animationTimingFunction;
    [self.layer addAnimation:animation forKey:@"fade"];
}

- (void)animateScale
{
    //Generate a small path
    self.interpolator.diameter = 0;
    CGPathRef smallPath = [self.interpolator pathForData:self.data
                                                  xRange:self.xRange
                                                  yRange:self.yRange
                                                  bounds:self.bounds];
    self.interpolator.diameter = self.diameter;

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"path"];
    animation.duration = self.animationDuration;
    animation.timingFunction = self.animationTimingFunction;
    animation.fromValue = (__bridge id _Nullable)(smallPath);
    animation.toValue = (__bridge id _Nullable)(self.layer.path);
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;

    [self.layer addAnimation:animation forKey:@"pathAnimation"];
}

#pragma mark - Getter/setter

- (void)setDiameter:(CGFloat)diameter
{
    _diameter = diameter;
    self.interpolator.diameter = diameter;
    [self updatePath];
}

@end
