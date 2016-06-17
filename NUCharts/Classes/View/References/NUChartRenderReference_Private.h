//
//  NUChartRenderReference_Private.h
//  Pods
//
//  Created by Victor Maraccini on 6/13/16.
//
//

@interface NUChartRenderReference (Private)
@property (nonatomic, readwrite) CGRect bounds;

- (CAShapeLayer *)drawAnimated:(BOOL)animated;
- (CAShapeLayer *)drawxAxisAnimated:(BOOL)animated;
- (CAShapeLayer *)drawyAxisAnimated:(BOOL)animated;
@end
