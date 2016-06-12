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

- (void)updatexAxis:(NUChartAxis *)xAxis animated:(BOOL)animated;
- (void)updateyAxis:(NUChartAxis *)yAxis animated:(BOOL)animated;
@end

@interface NUChartView : UIView

///Adds a dataset to the view and creates an independent axis.
///@remarks Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
- (NUChartRenderStructure *)addDataSet:(NUChartData *)data
                          withRenderer:(id<NUChartRenderer>)renderer;

///Adds a dataset to the view, associating it to a specific axis.
///@remarks Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
- (NUChartRenderStructure *)addDataSet:(NUChartData *)data
                          withRenderer:(id<NUChartRenderer>)renderer
                               toAxisX:(NUChartAxis *)xAxis
                                 axisY:(NUChartAxis *)yAxis;

///Gets the @c x axis for a dataset
- (NUChartAxis *)xAxisForDataSet:(NUChartData *)data;

///Gets the @c y axis for a dataset
- (NUChartAxis *)yAxisForDataSet:(NUChartData *)data;

///Removes a dataset from the view.
- (void)removeDataSet:(NUChartData *)data;

@end

NS_ASSUME_NONNULL_END
