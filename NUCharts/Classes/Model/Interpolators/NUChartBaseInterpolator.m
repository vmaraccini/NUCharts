//
//  NUBaseInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartBaseInterpolator.h"

@interface NUChartBaseInterpolator ()
@property (nonatomic, readwrite) CGPathRef mutablePath;
@property (nonatomic, readwrite) CGAffineTransform scaleTransform;
@end

@implementation NUChartBaseInterpolator

- (CGPathRef)pathForData:(NUChartData *)data
                  xRange:(NSRange)xRange
                  yRange:(NSRange)yRange
                  bounds:(CGRect)bounds
{
    if (CGRectIsEmpty(bounds)) {
        return NULL;
    }

    NSMutableArray<NSValue *>*filteredData = [NSMutableArray new];
    for (NSValue *wrapped in data.points) {
        CGPoint point = wrapped.CGPointValue;
        if ([self point:point.x withinRange:xRange] &&
            [self point:point.y withinRange:yRange]) {
            
            CGFloat invertedPoint = NSMaxRange(yRange) - point.y;
            [filteredData addObject:[NSNumber valueWithCGPoint:CGPointMake(point.x, invertedPoint)]];
        }
    }

    self.mutablePath = CGPathCreateMutable();

    CGFloat scaleX = xRange.length != NSNotFound ?
    bounds.size.width / xRange.length: 1;

    CGFloat scaleY = yRange.length != NSNotFound ?
    bounds.size.height / yRange.length : 1;
    self.scaleTransform = CGAffineTransformMakeScale(scaleX, scaleY);

    //Calls subclass implementation
    [self drawPoints:filteredData];

    return self.mutablePath;
}

- (void)drawPoints:(NSArray<NSValue *>*)points
{
    NU_ABSTRACT_METHOD
}

#pragma mark - Helper functions

- (BOOL)point:(CGFloat)point withinRange:(NSRange)range
{
    if (range.location == NSNotFound) {
        return YES;
    }
    return point >= range.location &&
    point <= NSMaxRange(range);
}

@end
