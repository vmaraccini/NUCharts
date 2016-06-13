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

///Adds a dataset to the view and creates an independent axis.
///@remarks Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
- (__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                   withRenderer:(id<NUChartRenderer>)renderer;

/**Adds a dataset to the view, associating it to a specific axis.
 @remarks Returns a @c NUChartRenderStructure, which you should use as reference when deleting/manipulating this chart.
 @remarks You may link this dataset's axes to another by supplying the other structure's axes.*/
- (__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                   withRenderer:(id<NUChartRenderer>)renderer
                                        toAxisX:(NUChartAxis *)xAxis
                                          axisY:(NUChartAxis *)yAxis;

///Removes a dataset from the view.
- (void)removeChartByReference:(NUChartRenderReference *)structure;

@end

NS_ASSUME_NONNULL_END
