//
//  CHActivityEllipses.m
//  Tag
//
//  Created by Chris O'Neil on 12/2/13.
//  Copyright (c) 2013 Arbrr. All rights reserved.
//

#import "CHActivityEllipses.h"

@implementation CHActivityEllipses
@synthesize bgColor, dotColor, interval;

-(id)initWithSize:(CGFloat)size backgroundColor:(UIColor *)bgc dotColor:(UIColor *)dc {
    width = size, height = size;
    self = [super initWithFrame:CGRectMake((kWidth - width)/2, (kHeight - height)/2, width, height)];
    if (self) {
        [self setDefaults];
        self.bgColor = bgc;
        self.dotColor = dc;

        radius = width / 8;
        padding = radius * .5, diameter = radius * 2;
        
        CALayer *layer = self.layer;
        layer.backgroundColor = self.bgColor.CGColor;
        layer.cornerRadius = width/8;
        
        // set up the dots
        CALayer *leftDot = [CALayer layer];
        leftDot.bounds = CGRectMake(0, 0, diameter, diameter);
        leftDot.position = CGPointMake(padding + radius, width / 2);
        leftDot.cornerRadius = radius;
        leftDot.backgroundColor = self.dotColor.CGColor;
        self->left = leftDot;
        [layer addSublayer:self->left];
        
        CALayer *centerDot = [CALayer layer];
        centerDot.bounds = CGRectMake(0, 0, diameter, diameter);
        centerDot.position = CGPointMake(padding + diameter + padding + radius, width / 2);
        centerDot.cornerRadius = radius;
        centerDot.backgroundColor = self.dotColor.CGColor;
        self->center = centerDot;
        [layer addSublayer:self->center];
        
        CALayer *rightDot = [CALayer layer];
        rightDot.bounds = CGRectMake(0, 0, diameter, diameter);
        rightDot.position = CGPointMake(padding + diameter + padding + diameter + padding + radius, width / 2);
        rightDot.cornerRadius = radius;
        rightDot.backgroundColor = self.dotColor.CGColor;
        self->right = rightDot;
        [layer addSublayer:self->right];
    }
    return self;
}

// sets the defaults for all of the properties.
-(void)setDefaults {
    self.backgroundColor = [UIColor blackColor];
    self.dotColor = [UIColor whiteColor];
    self.interval = .75f;
    animating = NO;
}


-(void)startActivity {
    if (!animating) {
        [self appear];
        animating = YES;
        [self animate];
    }
}


-(void)stopActivity {
    animating = NO;
    [self dissapear];
}

-(void)animate {
    self.interval = .75;
    [self fadeIn:left startsIn:interval/4 lastsFor:interval/2 addDelegate:NO];
    [self fadeIn:center startsIn:interval lastsFor:interval/2 addDelegate:NO];
    [self fadeIn:right startsIn:(interval * 2) lastsFor:interval/2 addDelegate:YES];
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (animating) {
        [self animate];
    }
}

// adds the animation that makes a dot fade in.
-(CABasicAnimation *)fadeIn:(CALayer *)dot startsIn:(float)delay lastsFor:(float)duration addDelegate:(BOOL)del  {
    
    // make sure dot has not animations
    [dot removeAllAnimations];
    
    // fade a dot in
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    if (del) animation.delegate = self;
    [dot addAnimation:animation forKey:@"opacityIN"];
    return animation;
}

// hides all of the dots
-(void)dissapear {
    left.opacity = 0;
    [left removeAllAnimations];
    center.opacity = 0;
    [center removeAllAnimations];
    right.opacity = 0;
    [right removeAllAnimations];
}

// shows all of the dots
-(void)appear {
    left.opacity = 1;
    center.opacity = 1;
    right.opacity = 1;
}

@end
