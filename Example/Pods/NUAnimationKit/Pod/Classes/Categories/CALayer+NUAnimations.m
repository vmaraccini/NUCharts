//
//  CALayer+NUAnimations.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 5/10/16.
//
//

#import "CALayer+NUAnimations.h"

@implementation CALayer (NUAnimations)

- (void)pauseAnimations {
    self.speed = 0;
    self.timeOffset = [self convertTime:CACurrentMediaTime() toLayer:nil];
}

- (void)resumeAnimations {
    self.speed = 1.f;
    self.timeOffset = 0;
    self.beginTime = 0;

    CFTimeInterval pausedTime = [self timeOffset];
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}

@end
