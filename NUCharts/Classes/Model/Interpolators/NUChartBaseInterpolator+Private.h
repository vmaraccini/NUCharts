//
//  NUBaseInterpolator+Private.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import "NUChartBaseInterpolator.h"

@interface NUChartBaseInterpolator (Private)

@property (nonatomic, readwrite) CGMutablePathRef mutablePath;
@property (nonatomic, readwrite) CGAffineTransform scaleTransform;

@end
