//
//  NUBaseAnimation.m
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUBaseAnimation.h"
#import "CALayer+NUAnimations.h"

@interface NUBaseAnimation ()
@property (nonatomic, strong) NSArray<NSValue *> *targetLayers;
@end

@implementation NUBaseAnimation

#pragma mark - Static

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations {
    return [self animationBlockWithType:type
                             andOptions:options
                               andDelay:delay
                          andAnimations:animations
                 andInitializationBlock:nil
                     andCompletionBlock:nil
                   andCancellationBlock:nil];
}

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                 andInitializationBlock: (NUNoArgumentsBlock)initializationBlock
                     andCompletionBlock: (NUNoArgumentsBlock)completionBlock
                   andCancellationBlock: (NUNoArgumentsBlock)cancellationBlock {
    
    NUBaseAnimation *block = [[NUBaseAnimation alloc]initWithType:type
                                                       andOptions:options
                                                         andDelay:delay
                                                    andAnimations:animations
                                           andInitializationBlock:initializationBlock
                                               andCompletionBlock:completionBlock
                                             andCancellationBlock:cancellationBlock];
    return block;
}

#pragma mark - Public

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.options = [[NUAnimationOptions alloc] init];
        self.type = NUAnimationTypeDefault;
    }
    return self;
}

- (instancetype)initWithType: (NUAnimationType)type
                  andOptions: (NUAnimationOptions *)options
                    andDelay: (NSTimeInterval)delay
               andAnimations: (NUSimpleAnimationBlock)animations
      andInitializationBlock: (NUNoArgumentsBlock)initializationBlock
          andCompletionBlock: (NUNoArgumentsBlock)completionBlock
        andCancellationBlock: (NUNoArgumentsBlock)cancellationBlock{
    NSParameterAssert(animations);
    NSParameterAssert(options);
    self = [super init];
    if (self) {
        _options = options;
        self.type = type;
        _delay = delay;
        _animationBlock = [animations copy];
        _initializationBlock = [initializationBlock copy];
        _completionBlock = [completionBlock copy];
        _cancellationBlock = [cancellationBlock copy];
    }
    return self;
}

- (void)setType:(NUAnimationType)type {
    _type = type;
    if (type == NUAnimationTypeSpringy) {
        self.options = [[NUSpringAnimationOptions alloc] initWithOptions:self.options];
    }
}

- (void)setAssociatedViews:(NSArray<UIView *>*)views {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:views.count];
    for (UIView *view in views) {
        [result addObject:[NSValue valueWithNonretainedObject:view.layer]];
    }
    _targetLayers = [result copy];
}

- (void)setTargetLayersOffset:(NSTimeInterval)offset {
    for (NSValue *targetLayerReference in self.targetLayers) {
        CALayer *targetLayer = [targetLayerReference nonretainedObjectValue];
        targetLayer.timeOffset = offset;
    }
}

- (void)pauseLayerAnimations {
    for (NSValue *targetLayerReference in self.targetLayers) {
        CALayer *targetLayer = [targetLayerReference nonretainedObjectValue];
        [targetLayer pauseAnimations];
    }
}

#pragma mark - Extension points

- (void)animationWillBegin {
    if (self.initializationBlock) {
        self.initializationBlock();
    }
}

- (void)animationDidFinish {
    if (self.completionBlock) {
        self.completionBlock();
    }
}

- (void)animationDidCancel {
    if (self.cancellationBlock) {
        self.cancellationBlock();
    }
}

@end
