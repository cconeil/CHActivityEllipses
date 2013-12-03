//
//  CHActivityEllipses.m
//  Tag
//
//  Created by Chris O'Neil on 12/2/13.
//  Copyright (c) 2013 Arbrr. All rights reserved.
//

#import "CHActivityEllipses.h"

@implementation CHActivityEllipses


-(id)initWithSize:(CGFloat)size backgroundColor:(UIColor *)bgc dotColor:(UIColor *)dc {
    width = size, height = size;
    self = [super initWithFrame:CGRectMake((kWidth - width)/2, (kHeight - height)/2, width, height)];
    if (self) {
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


-(void)startActivity {
    [self.superview setUserInteractionEnabled:NO];
    [self appear];
    [self animate];
    timer = [NSTimer scheduledTimerWithTimeInterval:1.5f
                                             target:self
                                           selector:@selector(animate)
                                           userInfo:nil
                                        repeats:YES];
}

-(void)stopActivity {
    if (timer != nil) {
        [timer invalidate];
    }
    [self.superview setUserInteractionEnabled:YES];
    [self dissapear];
}

-(void)animate {
    // add the new dots
    float interval = .5;
    [self fadeIn:left startsIn:0 lastsFor:interval/2];
    [self fadeIn:center startsIn:interval lastsFor:interval/2];
    [self fadeIn:right startsIn:(interval * 2) lastsFor:interval/2];
}

// adds the animation that makes a dot fade in.
-(void)fadeIn:(CALayer *)dot startsIn:(float)delay lastsFor:(float)duration  {

    // fade a dot in
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.beginTime = CACurrentMediaTime() + delay;
    animation.duration = duration;
    animation.fromValue = [NSNumber numberWithFloat:0.0f];
    animation.toValue = [NSNumber numberWithFloat:1.0f];
    animation.removedOnCompletion = YES;
    animation.fillMode = kCAFillModeBoth;
    animation.additive = NO;
    [dot addAnimation:animation forKey:@"opacityIN"];
}

// hides all of the dots
-(void)dissapear {
    left.opacity = 0;
    center.opacity = 0;
    right.opacity = 0;
}

// shows all of the dots
-(void)appear {
    left.opacity = 1;
    center.opacity = 1;
    right.opacity = 1;
}

@end
