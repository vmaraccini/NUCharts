//
//  NUAnimationController.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/21/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUCompositeAnimation.h"
#import "UIView+NUAnimationAdditions.h"

@interface NUAnimationController : NSObject

///Readonly boolean that reports whether animations have been canceled. It's value is reset to zero every time the animation begins.
@property (nonatomic, readonly) BOOL animationCancelled;
///Readonly integer that reports the current animation step
@property (nonatomic, readonly) int animationStep;
///Readonly boolean that reports whether animations are running
@property (nonatomic, readonly) BOOL animationRunning;

/**
 *  If set to @c YES, the animation blocks of each animation step
 passed in will be called synchronously if animations are cancelled.
 @discussion
 This ensures a consistent final state if animations are cancelled either by explicitly calling
 @c cancelAnimations or by changes in the view hierarchy
 */
@property (nonatomic, readwrite) BOOL shouldRunAllAnimationsIfCancelled;

/**Sets wether pending CALayer animations will be synchronized with the UIView animations. Default is YES.
 @discussion
 If set to YES, the controller will force pending CALayer animations to be commited using the same duration as the current animation block.
 */
@property (nonatomic) BOOL synchronizesLayerAnimations;

/**
 *  The NUAnimationController's completion block
 *
 *  @discussion This block is invoked when the last chained animations has finished
 */
@property (nonatomic, copy) NUNoArgumentsBlock completionBlock;

/**
 *  The NUAnimationController's cancellation block
 *
 *  @discussion This block is invoked if any of the animations in the chain are cancelled, either
 by explicitly calling @c cancelAnimations or if the animation is cancelled by the Core Animation
 framework.
 */
@property (nonatomic, copy) NUNoArgumentsBlock cancellationBlock;

/**
 *  The NUAnimationController's initialization block
 *
 *  @discussion This block is invoked before all animations begin
 */
@property (nonatomic, copy) NUNoArgumentsBlock initializationBlock;

///Adds an animation to the chain
- (NUBaseAnimation *)addAnimation:(NUBaseAnimation *)animation;
///Removes an animation from the chain
- (void)removeAnimation: (NUBaseAnimation *)animation;
///Clears the animation chain
- (void)removeAllAnimations;

///Returns an array with all the animation steps
- (NSArray *)animations;

///Returns a block that calls all animation blocks synchronously
- (NUNoArgumentsBlock)allAnimations;

///Returns the total animation duration (combining all the steps)
- (NSTimeInterval)totalAnimationTime;

///Starts the animation chain and calls @c completionBlock when done.
- (void)startAnimationChainWithCompletionBlock:(NUNoArgumentsBlock)completionBlock;
///Starts the animation chain
- (void)startAnimationChain;

///Starts the animation chain
- (void)animateToProgress:(CGFloat)progress;

//Convenience methods

///Adds an animation block to the chain
- (NUCompositeAnimation *)addAnimations:(NUSimpleAnimationBlock)animations;

///Adds a progress-based animation block to the chain
- (NUCompositeAnimation *)addProgressAnimations:(NUProgressAnimationBlock)animations;

///Finishes the current animation step and stops the animation chain
- (void)cancelAnimations;

@end
