//
//  NUChartView.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/29/16.
//
//

#import "NUChartView.h"
#import "NUChartRenderReference_Private.h"

@interface NUChartView () <NUChartRendererDelegate>
@property (nonatomic, strong) NSMutableArray<NUChartRenderReference *>*renderStructures;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic) UIEdgeInsets insets;
@end

@implementation NUChartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    _renderStructures = [NSMutableArray new];

    UIView *containerView = [UIView new];
    self.containerView = containerView;
    [self addSubview:self.containerView];

    self.clipsToBounds = YES;
}

#pragma mark - Overrides

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    self.containerView.frame = self.frame;
}

- (void)setBounds:(CGRect)bounds
{
    [super setBounds:bounds];

    for (NUChartRenderReference *reference in self.renderStructures) {
        [reference setBounds:bounds];
    }

    [self drawChart];
}

#pragma mark - Public

-(__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                  withRenderer:(id<NUChartDataRenderer>)renderer
{
    return [self addDataSet:data
               withRenderer:renderer
                    toAxisX:[[NUChartAxis alloc] initWithRange:[NUChartRange fullXRangeForData:data]]
                      axisY:[[NUChartAxis alloc] initWithRange:[NUChartRange fullYRangeForData:data]]];
}

- (__kindof NUChartRenderReference *)addDataSet:(NUChartData *)data
                                   withRenderer:(id<NUChartDataRenderer>)renderer
                                        toAxisX:(nonnull NUChartAxis *)xAxis
                                          axisY:(nonnull NUChartAxis *)yAxis
{

    NUChartRenderReference *reference =
    [NUChartRenderReferenceFactory renderReferenceForxAxis:xAxis
                                                     yAxis:yAxis
                                                      data:data
                                                  renderer:renderer
                                                    bounds:self.bounds];
    renderer.delegate = self;

    [self.renderStructures addObject:reference];
    [self drawChart];
    return reference;
}

- (void)removeChartByReference:(__kindof NUChartRenderReference *)structure {
    [self.renderStructures removeObject:structure];
    [self drawChart];
}

- (CGRect)rectForReference:(NUChartRenderReference *)reference
{
    return [self.containerView convertRect:[reference.renderer boundingRect]
                                      toView:self.superview];
}

#pragma mark - NUChartRendererDelegate

- (void)rendererWillUpdate:(id<NUChartRenderer>)renderer
{
    if (self.adjustsMarginsToFitContent) {
        [self updateMargins];
    }
}

#pragma mark - Private

-(void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }
    [super willMoveToSuperview:newSuperview];
}

- (void)drawChart
{
    //Remove existing layers
    [[self.containerView.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];

    [self.renderStructures enumerateObjectsUsingBlock:^(NUChartRenderReference * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.containerView.layer insertSublayer:[obj drawxAxisAnimated:YES] atIndex:0];
        [self.containerView.layer insertSublayer:[obj drawyAxisAnimated:YES] atIndex:0];
        [self.containerView.layer addSublayer:[obj drawAnimated:YES]];
    }];
}

- (void)updateMargins
{
    if (CGRectIsEmpty(self.bounds)) {
        return;
    }

    __block CGFloat margin = 0;
    [self.renderStructures enumerateObjectsUsingBlock:^(NUChartRenderReference * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        margin = MAX(margin, obj.renderer.requiredMargin);
        margin = MAX(margin, obj.xAxis.renderer.requiredMargin);
        margin = MAX(margin, obj.yAxis.renderer.requiredMargin);
    }];

    CGAffineTransform transform = CGAffineTransformMakeScale((self.bounds.size.width - 2*margin) / self.bounds.size.width,
                                                             (self.bounds.size.height - 2*margin) / self.bounds.size.height);
    transform = CGAffineTransformTranslate(transform, margin, margin);
    self.containerView.transform = transform;
}

@end
