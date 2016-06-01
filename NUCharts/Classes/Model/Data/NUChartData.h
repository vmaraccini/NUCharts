//
//  NUChartData.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/30/16.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NUChartData : NSObject<NSCopying>
@property (nonatomic, readonly) NSArray<NSValue *>* points;

- (instancetype)initWithxValues:(NSArray<NSNumber *>*)xValues
                        yValues:(NSArray<NSNumber *>*)yValues;

- (instancetype)initWithCGPointArray:(NSArray<NSValue *>*)points;


@property (nonatomic, readonly) CGFloat maximumX;
@property (nonatomic, readonly) CGFloat maximumY;

@property (nonatomic, readonly) CGFloat minimumY;
@property (nonatomic, readonly) CGFloat minimumX;

@end

NS_ASSUME_NONNULL_END
