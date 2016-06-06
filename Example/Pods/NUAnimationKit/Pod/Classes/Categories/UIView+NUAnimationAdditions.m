//
//  UIView+NUAnimationAdditions.m
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//
//

#import "UIView+NUAnimationAdditions.h"

@implementation UIView (NUAnimationAdditions)

//Frame settings
- (void)setFrameX: (CGFloat)x {
    self.frame = CGRectMake(x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}
- (void)setFrameY: (CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x,
                            y,
                            self.frame.size.width,
                            self.frame.size.height);
}

- (void)setFrameWidth: (CGFloat)w {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            w,
                            self.frame.size.height);
}

- (void)setFrameHeight: (CGFloat)h {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            h);
}

-(void)addFrameX:(CGFloat)dx {
    self.frame = CGRectMake(self.frame.origin.x + dx,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}

-(void)addFrameY:(CGFloat)dy {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y + dy,
                            self.frame.size.width,
                            self.frame.size.height);
}

-(void)addFrameWidth:(CGFloat)dw {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width + dw,
                            self.frame.size.height);
}

-(void)addFrameHeight:(CGFloat)dh {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height + dh);
}

//Layer settings
- (void)setLayerX: (CGFloat)x {
    self.layer.frame = CGRectMake(x,
                            self.layer.frame.origin.y,
                            self.layer.frame.size.width,
                            self.layer.frame.size.height);
}
- (void)setLayerY: (CGFloat)y {
    self.layer.frame = CGRectMake(self.layer.frame.origin.x,
                                  y,
                                  self.layer.frame.size.width,
                                  self.layer.frame.size.height);

}

- (void)setLayerWidth: (CGFloat)w {
    self.layer.frame = CGRectMake(self.layer.frame.origin.x,
                                  self.layer.frame.origin.y,
                                  w,
                                  self.layer.frame.size.height);
    
}

- (void)setLayerHeight: (CGFloat)h {
    self.layer.frame = CGRectMake(self.layer.frame.origin.x,
                                  self.layer.frame.origin.y,
                                  self.layer.frame.size.width,
                                  h);

}

-(void)addLayerX:(CGFloat)dx {
    self.frame = CGRectMake(self.frame.origin.x + dx,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height);
}

-(void)addLayerY:(CGFloat)dy {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y + dy,
                            self.frame.size.width,
                            self.frame.size.height);
}

-(void)addLayerWidth:(CGFloat)dw {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width + dw,
                            self.frame.size.height);
}

-(void)addLayerHeight:(CGFloat)dh {
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            self.frame.size.height + dh);
}

@end
