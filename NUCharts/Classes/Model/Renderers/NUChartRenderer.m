//
//  NUChartRenderer.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartRenderer.h"

@implementation NUChartRenderer

- (instancetype)initWithInterpolator:(id<NUChartInterpolator>)interpolator
{
    self = [super init];
    if (self) {
        _interpolator = interpolator;
        [self initialize];
    }
    return self;
}

- (instancetype)init
{
    id defaultInterpolator = [NUChartLinearInterpolator new];
    return [self initWithInterpolator:defaultInterpolator];
}

#pragma mark - Public

- (CAShapeLayer *)drawData:(NUChartData *)data
                    bounds:(CGRect)bounds
{
    CGPathRef path = [self.interpolator pathForData:data];
    return [self drawPath:path bounds:bounds];
}

#pragma mark - Private

- (void)initialize
{
    _strokeColor = [UIColor blackColor];
    _lineWidth = 1.f;
}

- (CAShapeLayer *__nullable)drawPath:(CGPathRef)path
                              bounds:(CGRect)bounds
{
    if (CGRectIsEmpty(bounds)) {
        return nil;
    }

    CGRect boundingRect = CGPathGetPathBoundingBox(path);
    CAShapeLayer *shape = [CAShapeLayer layer];

    CGFloat maxPathSize = MAX(boundingRect.size.width, boundingRect.size.height);
    CGFloat maxBoundsSize = MAX(bounds.size.width, bounds.size.height);
    CGFloat scale =  maxBoundsSize / maxPathSize;
    CGAffineTransform t = CGAffineTransformMakeScale(scale, scale);
    shape.path = CGPathCreateCopyByTransformingPath(path, &t);

    shape.strokeColor = self.strokeColor.CGColor;
    shape.lineWidth = self.lineWidth;
    shape.fillColor = [UIColor clearColor].CGColor;
    
    return shape;
}

@end