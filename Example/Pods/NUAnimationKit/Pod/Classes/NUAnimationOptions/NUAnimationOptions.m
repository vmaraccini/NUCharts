//
//  NUAnimationOptions.m
//  NUAnimationKit
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//  Copyright © 2016 Victor Gabriel Maraccini. All rights reserved.
//

#import "NUAnimationOptions.h"
#import "NUAnimationDefaults.h"

@implementation NUAnimationOptions

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = [[NUAnimationDefaults sharedDefaults] defaultDuration];
        self.options = [[NUAnimationDefaults sharedDefaults] defaultOptions];
        self.curve = [[NUAnimationDefaults sharedDefaults] defaultCurve];
    }
    return self;
}

+ (instancetype) animationWithDuration: (NSTimeInterval)duration
                            andOptions: (UIViewAnimationOptions)options
                              andCurve: (UIViewAnimationCurve)curve {
    NUAnimationOptions *result = [[NUAnimationOptions alloc] init];
    
    result.duration = duration;
    result.options = options;
    result.curve = curve;
    
    return result;
}
@end

@interface NUSpringAnimationOptions()
@property (nonatomic, readwrite) NSTimeInterval naturalDuration;
@end

@implementation NUSpringAnimationOptions

//Wow, such physics: https://en.wikipedia.org/wiki/Settling_time
//very mechanics: https://en.wikipedia.org/wiki/Mechanical_resonance
#define NUGetNaturalFrequency(spring, mass) 1.0f/(2.0f*M_PI)*sqrt(spring/mass)
#define NUSettleTolerance 0.1f //Based on empirical UI tests

double NUSpringAnimationNaturalDuration = -1;

#pragma mark - Static

+ (instancetype) animationWithDuration:(NSTimeInterval)duration
                            andOptions:(UIViewAnimationOptions)options
                              andCurve:(UIViewAnimationCurve)curve
                            andDamping:(CGFloat)damping
                    andInitialVelocity: (CGFloat)initialVelocity {
    NUSpringAnimationOptions *result = [[NUSpringAnimationOptions alloc] init];
    
    result.duration = duration;
    result.options = options;
    result.curve = curve;
    result.damping = damping;
    result.initialVelocity = initialVelocity;
    
    return result;
}

#pragma mark - Public

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (instancetype)initWithOptions: (NUAnimationOptions *)options {
    self = [super init];
    if (self) {
        [self initialize];
        self.options = options.options;
        self.duration = options.duration;
        self.curve = options.curve;
    }
    return self;
}

#pragma mark - Private

- (void)initialize {
    self.damping = [[NUAnimationDefaults sharedDefaults] defaultDamping];
    self.initialVelocity = [[NUAnimationDefaults sharedDefaults] defaultInitialVelocity];
    self.springMass = [[NUAnimationDefaults sharedDefaults] defaultSpringMass];
    self.springConstant = [[NUAnimationDefaults sharedDefaults] defaultSpringConstant];
    _naturalDuration = 0;
}

- (void)invalidatenaturalDuration {
    _naturalDuration = 0;
}

#pragma mark - Get/set

- (NSTimeInterval)naturalDuration {
    if (_naturalDuration != 0) {
        return _naturalDuration;
    }
    _naturalDuration = -log(NUSettleTolerance)/(self.damping*NUGetNaturalFrequency(self.springConstant, self.springMass));
    return _naturalDuration;
}

- (NSTimeInterval)duration {
    if (_duration == NUSpringAnimationNaturalDuration) {
        return self.naturalDuration;
    }
    return _duration;
}

//Settings that invalidate the natural time interval calculation
- (void)setSpringMass:(double)springMass {
    _springMass = springMass;
    [self invalidatenaturalDuration];
}

- (void)setSpringConstant:(double)springConstant {
    _springConstant = springConstant;
    [self invalidatenaturalDuration];
}

- (void)setDamping:(CGFloat)damping {
    _damping = damping;
    [self invalidatenaturalDuration];
}

@end