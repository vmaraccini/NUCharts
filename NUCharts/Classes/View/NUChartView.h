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
#import "NUChartPointRenderer.h"
#import "NUChartRenderReference.h"

NS_ASSUME_NONNULL_BEGIN

@interface NUChartView : UIView

///Sets whether this view will adjust the graph's insets so that no clipping of the desired range occurs.
///@discussion Use this property if you need the view to fit the desired range and prevent elements at the border from being clipped.
@property (nonatomic, readwrite) BOOL adjustsMarginsToFitContent;

///Adds a dataset to the view and creates an independent axis.
///@remarks Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
- (__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                   withRenderer:(id<NUChartDataRenderer>)renderer;

/**Adds a dataset to the view, associating it to a specific axis.
 @discussion Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
 @discussion You may configure how the axes are displayed directly in the corresponding @c NUChartAxis object.
 @remarks You may link this dataset's axes to another by supplying the other structure's axes.*/
- (__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                   withRenderer:(id<NUChartDataRenderer>)renderer
                                        toAxisX:(nonnull NUChartAxis *)xAxis
                                          axisY:(nonnull NUChartAxis *)yAxis;

///Removes a dataset from the view.
- (void)removeChartByReference:(NUChartRenderReference *)reference;

- (CGRect)rectForReference:(NUChartRenderReference *)reference;

@end

NS_ASSUME_NONNULL_END
