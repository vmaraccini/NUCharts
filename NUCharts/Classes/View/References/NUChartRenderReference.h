//
//  NUChartRenderReference.h
//  Pods
//
//  Created by Victor Maraccini on 6/13/16.
//
//

#import "NUChartData.h"
#import "NUChartAxis.h"
#import "NUChartLineRenderer.h"
#import "NUChartPointRenderer.h"

@interface NUChartRenderReference : NSObject

@property (nonatomic, readonly) NUChartAxis *xAxis;
@property (nonatomic, readonly) NUChartAxis *yAxis;

@property (nonatomic, readonly) NUChartData *data;
@property (nonatomic, readonly) id<NUChartRenderer> renderer;

//Update methods
- (void)updateData:(NUChartData *)data animated:(BOOL)animated;

- (void)updatexRange:(nullable NUChartRange *)xRange animated:(BOOL)animated;
- (void)updateyRange:(nullable NUChartRange *)yRange animated:(BOOL)animated;

///Adjusts x and y axis to fit data
- (void)fitAxisAnimated:(BOOL)animated;

@end

@interface NUChartLineRenderReference : NUChartRenderReference
@property (nonatomic, readonly) NUChartLineRenderer* renderer;
@end

@interface NUChartPointRenderReference : NUChartRenderReference
@property (nonatomic, readonly) NUChartPointRenderer* renderer;
@end

@interface NUChartRenderReferenceFactory : NSObject
+ (__kindof NUChartRenderReference *)renderReferenceForxAxis:(NUChartAxis *)xAxis
                                                       yAxis:(NUChartAxis *)yAxis
                                                        data:(NUChartData *)data
                                                    renderer:(id<NUChartRenderer>)renderer
                                                      bounds:(CGRect)bounds;
@end