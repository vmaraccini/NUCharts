<img src="./Pod/Assets/logo.png"/>

####UIView animation wrapper to facilitate chaining of animation commands.

###Problem
Chaining of UIView animations requires the use of completion handler blocks to chain commands together:

```objc
[UIView animateWithDuration:0.5
                          delay:0
                        options:0
                     animations:^{
                         [animationView1 setFrameY:400];
                         animationView1.backgroundColor = [UIColor grayColor];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.3
                                               delay:0.1
                                             options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              [animationView2 setFrameY:400];
                                          }
                                          completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.5
                                                                    delay:0
                                                   usingSpringWithDamping:0.5
                                                    initialSpringVelocity:0
                                                                  options:0
                                                               animations:^{
                                                                   [animationView3 setFrameY:400];
                                                               }
                                                               completion:nil];
                                          }];
                     }];
```
Which isn't a particularly elegant solution, and is hard to read.

### Features

#### UIView animation chaining

This library creates a wrapper around UIView animations that facilitates chaining via a simple syntax:

```objc
NUAnimationController *controller = [[NUAnimationController alloc] init];

[self.controller addAnimation:^{
    [animationView1 setFrameY:400];
    animationView1.backgroundColor = [UIColor grayColor];
}].withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve);
    
[self.controller addAnimation:^{
    [animationView2 setFrameY:400];
}].withDelay(0.1).withDuration(0.3).withCurve(UIViewAnimationCurveEaseInOut);
    
[self.controller addAnimation:^{
    [animationView3 setFrameY:400];
}].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration);
```
To achieve chaining in different objects:

<p align="center">
<img src="./Pod/Assets/baseAnimations.gif"/>
</p>

NUAnimationKit also allows you to set animation options on creation:

```objc
[controller addAnimation:^{
    //Animations
}].withDelay(0.1).withDuration(0.3).withCurve(UIViewAnimationCurveEaseInOut);
```

And spring-based animations:

```objc
controller addAnimation:^{
    //Springy
}].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration)
```
Where `NUSpringAnimationNaturalDuration ` is a constant that will automatically calculate the optimal spring animation duration based on physical properties like *mass* and *elastic constant*.

Like so:

<p align="center">
<img src="./Pod/Assets/parallelSprings.gif"/>
</p>

#### Progress-based explicit animations

And also adds support for progress-based blocks, for properties that may not be directly animatable.

They can be animated alongside another UIView animation:

```objc
[controller addAnimation:^{
    //Main animation
}].alongSideBlock(^(CGFloat progress){
    progressLabel.text = [NSString stringWithFormat:@"%f", progress];
});
```

Or created entirely on their own:

```objc
[self.controller addProgressAnimations:^(CGFloat progress) {
  progressLabel.text = [NSString stringWithFormat:@"%f", progress];
}].withDuration(2);
```

Like setting a string value:

<p align="center">
<img src="./Pod/Assets/stringAnimation.gif"/>
</p>

#### Progress-based UIView animations

<p align="center">
<img src="./Pod/Assets/animation_progress.gif"/>
</p>

NUAnimationKit also supports creating parametrized animations using simple UIView animation blocks

1 - Build your block animation as usual, but setting the views associated with the transformations you are making:
```objc
[self.controller addAnimations:^{
     [animationView1 setFrameY:400];
     animationView1.backgroundColor = [UIColor grayColor];
}].withAnimationOption(UIViewAnimationOptionTransitionCrossDissolve)
.withDuration(2)
.withAssociatedViews(@[animationView1]);
```

> Note: You may still add as many animation blocks as you like. The order, duration and delay of each one will be preserved.

2 - Call the progress update block whenever you need to change the animation state:
```objc
[self.controller animateToProgress:progress];
```

#### Caveats:
This animation method does not support the chaining of `before` and `after` blocks.


## Installation

NUAnimationKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "NUAnimationKit"
```

## Usage
To use the library, simply:

- Install the pod by adding `pod "NUAnimationKit"` to your podfile
- Import `NUAnimationController.h`
- Create an animation controller: 

```objc
NUAnimationController *controller = [[NUAnimationController alloc] init];
```
- Add animation blocks:

```objc
[controller addAnimation:^{
    //Springy
}].withType(NUAnimationTypeSpringy).withDuration(NUSpringAnimationNaturalDuration)
```
- Start the animation: 

```objc
[controller startAnimationChain]
```
or

```objc
[controller startAnimationChainWithCompletionBlock:^{
//Optional completion block
}];
```

- Profit

## Requirements
Built for iOS 8.0 and above.

## Author

Victor Maraccini, 
victor.maraccini@nubank.com.br

## License

NUAnimationKit is available under the MIT license. See the LICENSE file for more info.
