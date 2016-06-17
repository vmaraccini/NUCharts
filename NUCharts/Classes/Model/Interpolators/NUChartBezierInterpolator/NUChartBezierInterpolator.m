//
//  NUChartBezierInterpolator.m
//  Pods
//
//  Created by Victor Maraccini on 6/12/16.
//
//

#import "NUChartBezierInterpolator.h"
#import "NUChartBaseInterpolator+Private.h"

@interface NUChartBezierInterpolator ()
@property (nonatomic, strong) NSMutableArray<NSNumber *>*a;
@property (nonatomic, strong) NSMutableArray<NSNumber *>*b;
@property (nonatomic, strong) NSMutableArray<NSNumber *>*c;

@property (nonatomic, strong) NSMutableArray<NSValue *>*rhsPoints;

@property (nonatomic, strong) NSMutableArray<NSValue *>*ctrlPoints1;
@property (nonatomic, strong) NSMutableArray<NSValue *>*ctrlPoints2;
@end

@implementation NUChartBezierInterpolator

#pragma mark - Extension points

- (void)drawPoints:(NSArray<NSValue *> *)points
{
    if (points.count < 3) {
        self.mutablePath = NULL;
    }

    UIBezierPath *path = [UIBezierPath bezierPath];

    [self buildCoefficientsForData:points];
    [self solveSystem];
    [self buildControlPointsForData:points];

    CGPoint previousPoint = CGPointApplyAffineTransform(points[0].CGPointValue, self.scaleTransform);
    [path moveToPoint:previousPoint];

    for (int i = 1; i < points.count; i++) {
        CGPoint currentPoint = CGPointApplyAffineTransform(points[i].CGPointValue, self.scaleTransform);;

        [self drawPoint:currentPoint
          previousPoint:previousPoint
          controlPoint1:self.ctrlPoints1[i-1].CGPointValue
          controlPoint2:self.ctrlPoints2[i-1].CGPointValue
                   path:path];

        previousPoint = currentPoint;
    }

    self.mutablePath = CFBridgingRetain(path.CGPath);
}

- (void)drawPoint:(CGPoint)currentPoint
    previousPoint:(CGPoint)previousPoint
    controlPoint1:(CGPoint)cp1
    controlPoint2:(CGPoint)cp2
             path:(UIBezierPath *)path
{
    [path addCurveToPoint:currentPoint
            controlPoint1:cp1
            controlPoint2:cp2];
}

#pragma mark - Math
//https://medium.com/@ramshandilya/draw-smooth-curves-through-a-set-of-points-in-ios-34f6d73c8f9#.ix1abmbrh

- (void)buildCoefficientsForData:(NSArray<NSValue *>*)points
{
    self.a = [NSMutableArray new];
    self.b = [NSMutableArray new];
    self.c = [NSMutableArray new];

    self.rhsPoints = [NSMutableArray new];

    NSUInteger count = points.count - 1;

    for (int i = 0; i < count; i++) {
        CGFloat rhsX = 0;
        CGFloat rhsY = 0;

        CGPoint p0 =
        CGPointApplyAffineTransform(points[i].CGPointValue, self.scaleTransform);

        CGPoint p3 =
        CGPointApplyAffineTransform(points[i+1].CGPointValue, self.scaleTransform);

        //Extremes
        if (i == 0) {
            [self.a addObject:@(0)];
            [self.b addObject:@(2)];
            [self.c addObject:@(1)];

            rhsX = p0.x + 2*p3.x;
            rhsY = p0.y + 2*p3.y;
        } else if (i == count - 1) {
            [self.a addObject:@(2)];
            [self.b addObject:@(7)];
            [self.c addObject:@(0)];

            rhsX = 8*p0.x + p3.x;
            rhsY = 8*p0.y + p3.y;
        } else {
            [self.a addObject:@(1)];
            [self.b addObject:@(4)];
            [self.c addObject:@(1)];

            rhsX = 4*p0.x + 2*p3.x;
            rhsY = 4*p0.y + 2*p3.y;
        }

        [self.rhsPoints addObject:[NSValue valueWithCGPoint:CGPointMake(rhsX, rhsY)]];
    }
}

- (void)solveSystem
{
    NSUInteger count = self.rhsPoints.count;
    for (int i = 1; i < count; i++) {
        CGFloat rhsX = self.rhsPoints[i].CGPointValue.x;
        CGFloat rhsY = self.rhsPoints[i].CGPointValue.y;

        CGFloat prefRHSX = self.rhsPoints[i - 1].CGPointValue.x;
        CGFloat prefRHSY = self.rhsPoints[i - 1].CGPointValue.y;

        CGFloat m = self.a[i].doubleValue / self.b[i-1].doubleValue;

        self.b[i] = @(self.b[i].doubleValue - m * self.c[i-1].doubleValue);

        CGFloat r2x = rhsX - m * prefRHSX;
        CGFloat r2y = rhsY - m * prefRHSY;

        self.rhsPoints[i] = [NSValue valueWithCGPoint:CGPointMake(r2x, r2y)];
    }
}

- (void)buildControlPointsForData:(NSArray<NSValue *>*)points
{
    NSUInteger count = self.rhsPoints.count;
    self.ctrlPoints1 = [[NSMutableArray alloc] initWithCapacity:count];
    self.ctrlPoints2 = [[NSMutableArray alloc] initWithCapacity:count];

    for (int i = 0; i < count; i++) {
        self.ctrlPoints1[i] = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
        self.ctrlPoints2[i] = [NSValue valueWithCGPoint:CGPointMake(0, 0)];
    }

    CGFloat lastCPX = self.rhsPoints[count - 1].CGPointValue.x / self.b[count - 1].doubleValue;
    CGFloat lastCPY = self.rhsPoints[count - 1].CGPointValue.y / self.b[count - 1].doubleValue;

    self.ctrlPoints1[count - 1] = [NSValue valueWithCGPoint:CGPointMake(lastCPX, lastCPY)];

    CGPoint nextCP;
    for (NSInteger i = count - 2; i >= 0; i--) {
        nextCP = self.ctrlPoints1[i+1].CGPointValue;

        CGFloat cpX =
        (self.rhsPoints[i].CGPointValue.x - self.c[i].doubleValue * nextCP.x) / self.b[i].doubleValue;

        CGFloat cpY =
        (self.rhsPoints[i].CGPointValue.y - self.c[i].doubleValue * nextCP.y) / self.b[i].doubleValue;

        self.ctrlPoints1[i] = [NSValue valueWithCGPoint:CGPointMake(cpX, cpY)];
    }

    for (int i = 0; i < count; i++) {
        CGPoint P3 =
        CGPointApplyAffineTransform(points[i+1].CGPointValue, self.scaleTransform);

        if (i == count - 1) {
            CGPoint P1 = self.ctrlPoints1[i].CGPointValue;
            CGFloat ctrl2X = (P3.x + P1.x) / 2.f;
            CGFloat ctrl2Y = (P3.y + P1.y) / 2.f;

            self.ctrlPoints2[i] = [NSValue valueWithCGPoint:CGPointMake(ctrl2X, ctrl2Y)];
        } else {
            CGPoint nextP1 = self.ctrlPoints1[i+1].CGPointValue;
            
            CGFloat ctrl2X = 2*P3.x - nextP1.x;
            CGFloat ctrl2Y = 2*P3.y - nextP1.y;
            
            self.ctrlPoints2[i] = [NSValue valueWithCGPoint:CGPointMake(ctrl2X, ctrl2Y)];
        }
    }
}

@end
