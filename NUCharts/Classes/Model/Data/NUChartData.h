//
//  NUChartData.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUChartData : NSObject
@property (nonatomic, strong) NSArray<NSNumber *> *xValues;
@property (nonatomic, strong) NSArray<NSNumber *> *yValues;

- (instancetype)initWithxValues:(NSArray<NSNumber *>*)xValues
                        yValues:(NSArray<NSNumber *>*)yValues;
@end

NS_ASSUME_NONNULL_END
