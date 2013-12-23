//
//  CHActivityEllipses.h
//  Tag
//
//  Created by Chris O'Neil on 12/2/13.
//  Copyright (c) 2013 Arbrr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

@interface CHActivityEllipses : UIView {
    float width, height, padding, diameter, radius;
    CALayer *left, *center, *right;
    NSTimer *timer;
}

-(void)startActivity;
-(void)stopActivity;
-(id)initWithSize:(CGFloat)size backgroundColor:(UIColor *)bgc dotColor:(UIColor *)dc;

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *dotColor;

@end
