//
//  NUBaseInterpolator.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartBaseInterpolator.h"
#import "NUChartAxis.h"

@interface NUChartBaseInterpolator ()
@property (nonatomic, readwrite) CGPathRef mutablePath;
@property (nonatomic, readwrite) CGAffineTransform scaleTransform;
@end

@implementation NUChartBaseInterpolator

- (CGPathRef)pathForData:(NUChartData *)data
                  xRange:(NUChartRange *)xRange
                  yRange:(NUChartRange *)yRange
                  bounds:(CGRect)bounds
{
    if (CGRectIsEmpty(bounds)) {
        return NULL;
    }

    NSMutableArray<NSValue *>*filteredData = [NSMutableArray new];
    for (NSValue *wrapped in data.points) {
        CGPoint point = wrapped.CGPointValue;
        CGFloat invertedPoint = yRange.maximum - point.y;
        [filteredData addObject:[NSNumber valueWithCGPoint:CGPointMake(point.x, invertedPoint)]];
    }

    self.mutablePath = CGPathCreateMutable();

    CGFloat scaleX = !xRange.isEmpty ?
    bounds.size.width / xRange.span: 1;

    CGFloat scaleY = !yRange.isEmpty ?
    bounds.size.height / yRange.span : 1;
    self.scaleTransform = CGAffineTransformMakeScale(scaleX, scaleY);

    //Calls subclass implementation
    [self drawPoints:filteredData];

    return self.mutablePath;
}

- (void)drawPoints:(NSArray<NSValue *>*)points
{
    NU_ABSTRACT_METHOD
}

@end
