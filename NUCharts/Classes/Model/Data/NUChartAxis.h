//
//  NUChartAxis.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 6/1/16.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUChartAxis : NSObject
@property (nonatomic, readonly) NSRange range;

- (instancetype)initWithRange:(NSRange)range;

@end

NS_ASSUME_NONNULL_END
