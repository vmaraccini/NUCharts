//
//  NUBaseAnimation.h
//  NUAnimationKit
//
//  Created by Victor Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NUAnimationOptions.h"
#import <UIKit/UIKit.h>

//Block definitions
typedef void (^NUSimpleAnimationBlock)(void);
typedef void (^NUProgressAnimationBlock)(CGFloat progress);

typedef void (^NUNoArgumentsBlock)(void);

//Types
typedef NS_ENUM(NSInteger, NUAnimationType) {
    NUAnimationTypeDefault,
    NUAnimationTypeSpringy,
};

//Base class
@interface NUBaseAnimation : NSObject

@property (nonatomic) NUAnimationType type;
@property NUAnimationOptions *options;
@property NSTimeInterval delay;

///UIView animations to be performed
@property (nonatomic, copy) NUSimpleAnimationBlock animationBlock;

///Block called when animation finishes successfully
@property (nonatomic, copy) NUNoArgumentsBlock completionBlock;

/**
 *  Block invoked when animation is cancelled.
 @discussion
 By default, no action is taken when the animation is cancelled.
 If you need to reliably get to a state after you trigger animations, even if they are cancelled,
 you should supply your @c animationBlock here.
 */
@property (nonatomic, copy) NUNoArgumentsBlock cancellationBlock;

//!Block called before animation starts
@property (nonatomic, copy) NUNoArgumentsBlock initializationBlock;

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations;

+ (instancetype) animationBlockWithType: (NUAnimationType)type
                             andOptions: (NUAnimationOptions *)options
                               andDelay: (NSTimeInterval)delay
                          andAnimations: (NUSimpleAnimationBlock)animations
                 andInitializationBlock: (NUNoArgumentsBlock)initializationBlock
                     andCompletionBlock: (NUNoArgumentsBlock)completionBlock
                   andCancellationBlock: (NUNoArgumentsBlock)cancellationBlock;

///Invoked when the controller is about to start the animation
- (void)animationWillBegin;

///Invoked when the animation is finished
- (void)animationDidFinish;

///Sets the views associated with this animation. MUST be supplied if you need the progress-based behavior.
- (void)setAssociatedViews:(NSArray<UIView *>*)views;

/**
 *  Invoked when the animation is cancelled, either by the view hierarchy or by calling @c cancelAnimations on the controller.
 @discussion
 Animations can be prematurelly terminated by iOS's Core Animation framework when a UIView is no longer visible.
 In that case, you may need to do some final adjustments to your internal view's state, 
 */
- (void)animationDidCancel;

@end
