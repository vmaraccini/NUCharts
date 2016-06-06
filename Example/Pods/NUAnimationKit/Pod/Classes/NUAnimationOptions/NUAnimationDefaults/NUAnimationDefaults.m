//
//  NUAnimationDefaults.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//
//

#import "NUAnimationDefaults.h"

@interface NUAnimationDefaults ()
@property (nonatomic, strong) NUAnimationDefaults *instance;
@end

@implementation NUAnimationDefaults

+ (instancetype)sharedDefaults {
    static NUAnimationDefaults *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _defaultDuration = 0.5;
        _defaultCurve = UIViewAnimationCurveLinear;
        _defaultOptions = 0;
        _defaultDamping = 0.5;
        _defaultInitialVelocity = 0;
        _defaultSpringMass = 1;
        _defaultSpringConstant = 1E3;
    }
    return self;
}

@end