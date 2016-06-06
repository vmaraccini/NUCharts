//
//  NUAnimationOptions.h
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NUAnimationOptions : NSObject {
    NSTimeInterval _duration;
}

///The animation duration, in seconds
@property NSTimeInterval duration;
///The options for this animation
@property UIViewAnimationOptions options;
///The animation easing curve
@property UIViewAnimationCurve curve;

+ (instancetype) animationWithDuration: (NSTimeInterval)duration
                            andOptions: (UIViewAnimationOptions)options
                              andCurve: (UIViewAnimationCurve)curve;

@end

@interface NUSpringAnimationOptions : NUAnimationOptions

extern NSTimeInterval NUSpringAnimationNaturalDuration;

//Physics-related
///Parameter that specifies the settle tolerance to calculate the length of spring animations
@property (nonatomic) double settleTolerance;
///The spring mass, in Kg
@property (nonatomic) double springMass;
///The spring constant, in N/m
@property (nonatomic) double springConstant;

//Animation-related
///The spring damping coefficient (0 - 1)
@property (nonatomic) CGFloat damping;
///The spring's initial velocity
@property (nonatomic) CGFloat initialVelocity;

- (instancetype)initWithOptions: (NUAnimationOptions *)options;

+ (instancetype) animationWithDuration: (NSTimeInterval)duration
                            andOptions: (UIViewAnimationOptions)options
                              andCurve: (UIViewAnimationCurve)curve
                            andDamping: (CGFloat)damping
                    andInitialVelocity: (CGFloat)initialVelocity;

///Gets the natural duration of the spring animation
- (NSTimeInterval)naturalDuration;

@end