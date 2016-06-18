//
//  NUChartProtocols.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import "NUChartData.h"

#define NU_ABSTRACT_METHOD NSString *errorString = [NSString stringWithFormat:@"You must implement %s in your subclass of NUChartBaseRenderer", __PRETTY_FUNCTION__];@throw [NSException exceptionWithName:@"Unimplemented method" reason:errorString userInfo:nil];

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, NUChartAxisPriority) {
    NUChartAxisPriorityPrimary, //Left for Y, Bottom for X
    NUChartAxisPrioritySecondary, //Right for Y, Top for X
};

typedef NS_ENUM(NSUInteger, NUChartAxisOrientation) {
    NUChartAxisOrientationX,
    NUChartAxisOrientationY,
};

@class NUChartRange, NUChartAxis;

// Interpolator

@protocol NUChartInterpolator <NSObject>
///Override point. Creates and returns a CGPath for the data set
- (nullable CGPathRef)newPathForData:(NUChartData *)data
                              xRange:(NUChartRange *)xRange
                              yRange:(NUChartRange *)yRange
                              bounds:(CGRect)bounds;
@end

// Renderer

@protocol NUChartRendererDelegate;
@protocol NUChartRenderer <NSObject>

@property (nonatomic, weak) id<NUChartRendererDelegate>delegate;

- (nullable CAShapeLayer *)updatePath:(CGPathRef)path
                               bounds:(CGRect)bounds
                             animated:(BOOL)animated;

///Returns the bouding rect of this renderer's representation
- (CGRect)boundingRect;

///Returns the required margin to fit the content being displayed
- (CGFloat)requiredMargin;

@end

@protocol NUChartRendererDelegate <NSObject>
///Called when renderers update their internal views
- (void)rendererWillUpdate:(id<NUChartRenderer>)renderer;
@end

@protocol NUChartDataRenderer <NUChartRenderer>

///Renders a data set into the rectangle determined by @c bounds and returns a CAShapeLayer
- (nullable CAShapeLayer *)updateData:(NUChartData *)data
                               xRange:(NUChartRange *)xRange
                               yRange:(NUChartRange *)yRange
                               bounds:(CGRect)bounds
                             animated:(BOOL)animated;

@end

@protocol NUChartAxisRenderer <NSObject>

///Returns the required margin to fit the content being displayed
- (CGFloat)requiredMargin;

///Renders an axis into the rectangle determined by @c bounds and returns a CAShapeLayer
- (nullable CAShapeLayer *)updateAxis:(NUChartAxis *)axis
                      orthogonalRange:(NUChartRange *)orthogonalRange
                          orientation:(NUChartAxisOrientation)orientation
                               bounds:(CGRect)bounds
                             animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END
