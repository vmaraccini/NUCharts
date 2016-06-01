//
//  NUChartPointRenderer.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import <Foundation/Foundation.h>
#import "NUChartBaseRenderer.h"
#import "NUChartProtocols.h"

@interface NUChartPointRenderer : NUChartBaseRenderer

@property (nonatomic, readwrite) CGFloat diameter;
@property (nonatomic, readwrite) CGFloat strokeWidth;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, strong) UIColor *fillColor;

@end
