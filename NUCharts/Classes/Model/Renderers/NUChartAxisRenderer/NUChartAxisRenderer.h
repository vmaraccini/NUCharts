//
//  NUChartAxisRenderer.h
//  Pods
//
//  Created by Victor Maraccini on 6/14/16.
//
//

#import "NUChartProtocols.h"

@interface NUChartAxisRenderer : NSObject <NUChartAxisRenderer>


//------------------- Axis line
@property (nonatomic, readwrite) BOOL displaysAxisLine;

///Sets the point at which this axis intercepts the orthogonal axis.
@property (nonatomic, readwrite) CGFloat intercept;

///Sets the renderer for the axis line.
@property (nonatomic, readwrite) id<NUChartRenderer>axisLineRenderer;


//------------------- Ticks
@property (nonatomic, readwrite) BOOL displaysAxisTicks;

///Sets the frequency (i.e.: every nth value) with which thicks are drawn
@property (nonatomic, readwrite) CGFloat tickFrequency;

///Sets the height of each axis tick
@property (nonatomic, readwrite) CGFloat tickHeight;

///Sets the renderer for the minor axis lines.
@property (nonatomic, readwrite) id<NUChartRenderer>tickRenderer;


//------------------- Minor lines
@property (nonatomic, readwrite) BOOL displaysAxisMinorLines;

///Sets the frequency (i.e.: every nth value) with which minor lines are drawn
@property (nonatomic, readwrite) CGFloat minorLineFrequency;

///Sets the renderer for the minor axis lines.
@property (nonatomic, readwrite) id<NUChartRenderer>minorLinesRenderer;


//------------------- Major lines
@property (nonatomic, readwrite) BOOL displaysAxisMajorLines;

///Sets the frequency (i.e.: every nth value) with which major lines are drawn
@property (nonatomic, readwrite) CGFloat majorLineFrequency;

///Sets the renderer for the major axis lines.
@property (nonatomic, readwrite) id<NUChartRenderer>majorLinesRenderer;
@end
