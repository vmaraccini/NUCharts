//
//  UIView+NUAnimationAdditions.h
//  Pods
//
//  Created by Victor Gabriel Maraccini on 1/22/16.
//
//

#import <UIKit/UIKit.h>

@interface UIView (NUAnimationAdditions)

//Frame settings

///Sets the origin x of a view's frame.
- (void)setFrameX:(CGFloat)x;

///Sets the origin y of a view's frame.
- (void)setFrameY:(CGFloat)y;

///Sets the width of a view's frame.
- (void)setFrameWidth:(CGFloat)w;

///Sets the height of a view's frame.
- (void)setFrameHeight:(CGFloat)h;

///Increments the x value of a frame
- (void)addFrameX:(CGFloat)dx;

///Increments the y value of a frame
- (void)addFrameY:(CGFloat)dy;

///Increments the width of a frame
- (void)addFrameWidth:(CGFloat)dw;

///Increments the height of a frame
- (void)addFrameHeight:(CGFloat)dh;

//Layer settings
///Sets the origin x of a view's layer.
- (void)setLayerX:(CGFloat)x;

///Sets the origin y of a view's layer.
- (void)setLayerY:(CGFloat)y;

///Sets the width of a view's layer.
- (void)setLayerWidth:(CGFloat)w;

///Sets the height of a view's layer.
- (void)setLayerHeight:(CGFloat)h;

///Increments the x value of a layer
- (void)addLayerX:(CGFloat)dx;

///Increments the y value of a layer
- (void)addLayerY:(CGFloat)dy;

///Increments the width of a layer
- (void)addLayerWidth:(CGFloat)dw;

///Increments the height of a layer
- (void)addLayerHeight:(CGFloat)dh;

@end
