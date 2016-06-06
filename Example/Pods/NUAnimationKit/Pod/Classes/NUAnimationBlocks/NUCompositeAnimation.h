//
//  NUCompositeAnimation.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUBaseAnimation.h"

@interface NUCompositeAnimation : NUBaseAnimation

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                     andCompletionBlock: (NUNoArgumentsBlock)completionBlock
                   andCancellationBlock: (NUNoArgumentsBlock)cancellationBlock
                         inParallelWith: (NUBaseAnimation *)parallelBlock
                       animateAlongside: (NUProgressAnimationBlock)progressBlock;

///An animation that will be started concurrently with this.
@property (nonatomic, strong) NUBaseAnimation *parallelBlock;
///A progress-based animation block that will be animated alongside this.
@property (nonatomic, strong) NUProgressAnimationBlock progressBlock;

- (NUCompositeAnimation * (^)(NUAnimationType))withType;
- (NUCompositeAnimation * (^)(NSTimeInterval))withDelay;

//Initialization
- (NUCompositeAnimation * (^)(NUNoArgumentsBlock))butBefore;

//Completion
- (NUCompositeAnimation * (^)(NUNoArgumentsBlock))andThen;

//Cancellation
- (NUCompositeAnimation * (^)(NUNoArgumentsBlock))ifCancelled;

//Options
- (NUCompositeAnimation * (^)(UIViewAnimationCurve))withCurve;
- (NUCompositeAnimation * (^)(UIViewAnimationOptions))withAnimationOption;
- (NUCompositeAnimation * (^)(NSTimeInterval))withDuration;
- (NUCompositeAnimation * (^)(NUAnimationOptions *))withOptions;

//  Springy options
- (NUCompositeAnimation * (^)(CGFloat))withDamping;
- (NUCompositeAnimation * (^)(CGFloat))withInitialVelocity;

//Progress
- (NUCompositeAnimation * (^)(NUProgressAnimationBlock))alongSideBlock;

//Parallel
- (NUCompositeAnimation * (^)(NUSimpleAnimationBlock))inParallelWith;

//Progress-based animations
- (NUCompositeAnimation * (^)(NSArray<UIView *>*))withAssociatedViews;

@end
