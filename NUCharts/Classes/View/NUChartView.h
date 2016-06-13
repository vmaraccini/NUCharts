//
//  NUChartView.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import <UIKit/UIKit.h>
#import "NUChartData.h"
#import "NUChartAxis.h"
#import "NUChartLineRenderer.h"

NS_ASSUME_NONNULL_BEGIN

@interface NUChartRenderStructure : NSObject
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

@interface NUChartView : UIView

///Adds a dataset to the view and creates an independent axis.
///@remarks Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
- (NUChartRenderStructure *)addDataSet:(NUChartData *)data
                          withRenderer:(id<NUChartRenderer>)renderer;

/**Adds a dataset to the view, associating it to a specific axis.
 @remarks Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
 @remarks You may link this dataset's axes to another by supplying the other structure's axes.*/
- (NUChartRenderStructure *)addDataSet:(NUChartData *)data
                          withRenderer:(id<NUChartRenderer>)renderer
                               toAxisX:(NUChartAxis *)xAxis
                                 axisY:(NUChartAxis *)yAxis;

///Removes a dataset from the view.
- (void)removeChartByReference:(NUChartRenderStructure *)structure;

@end

NS_ASSUME_NONNULL_END
