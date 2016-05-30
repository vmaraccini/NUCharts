//
//  NUChartView.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import <UIKit/UIKit.h>
#import "NUChartData.h"
#import "NUChartRenderer.h"

NS_ASSUME_NONNULL_BEGIN

@interface NUChartView : UIView
@property (nonatomic, strong) NUChartData *chartData;
@property (nonatomic, strong) NUChartRenderer *chartRenderer;
@end

NS_ASSUME_NONNULL_END
