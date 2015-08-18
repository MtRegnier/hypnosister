//
//  BNRHypnosisView.m
//  Hypnosister
//
//  Created by Dane on 8/17/15.
//  Copyright (c) 2015 Regnier Design. All rights reserved.
//

#import "BNRHypnosisView.h"

@implementation BNRHypnosisView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // BNRHypnosis views start off with a clear background color
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    CGRect bounds = self.bounds;
    
    // Figuring out where the center of the bounds is
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // Make the circle as large as will fit
    // Commented out for multiple circles
//    float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    
    // Making the largest, should circumscribe view
    float maxRadius = hypot(bounds.size.width, bounds.size.height / 2.0);
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Add an arc to the path at the center
    // Commented out for making multiple circles
//    [path addArcWithCenter:center
//                    radius:radius 
//                startAngle:0.0 
//                  endAngle:M_PI * 2.0 
//                 clockwise:YES];
    
    // Making the other circles as they get smaller
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        [path addArcWithCenter:center
                             radius:currentRadius 
                         startAngle:0.0 
                           endAngle:M_PI * 2.0 
                          clockwise:YES];
    }
    
    
    // Settings for stroke
    path.lineWidth = 10;
    [[UIColor lightGrayColor] setStroke];
    
    // Adding in the image
    UIImage *logoImage = [UIImage imageNamed:@"BNRLogo.png"];
    
    // DRAW!
    [path stroke];
    
    CGRect imageBounds = CGRectMake(100, 178, 176.0, 231.0);
    
    // Making points for the clipping path and gradient
    CGPoint gradientEnd = CGPointMake(imageBounds.origin.x + 88, imageBounds.origin.y);
    
    CGPoint gradientStart = CGPointMake(imageBounds.origin.x + 88, (imageBounds.origin.y + imageBounds.size.height));
    
    CGPoint clipPointOne = CGPointMake(imageBounds.origin.x, imageBounds.origin.y + 231);
    
    CGPoint clipPointTwo = CGPointMake(imageBounds.origin.x + imageBounds.size.width, imageBounds.origin.y + 231);
    
    UIBezierPath *clippingPath = [[UIBezierPath alloc] init];
    
    [clippingPath moveToPoint:gradientEnd];
    [clippingPath addLineToPoint:clipPointOne];
    [clippingPath addLineToPoint:clipPointTwo];
//    [clippingPath addLineToPoint:gradientEnd];
    [clippingPath closePath];
    
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {1.0, 1.0, 0, 1.0, 0, 1.0, 0, 1.0};
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    // Setting up the context for the gradient
    CGContextSaveGState(currentContext);
    
    [clippingPath addClip];
    CGContextDrawLinearGradient(currentContext, gradient, gradientStart, gradientEnd, 0);
    
    CGContextRestoreGState(currentContext);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    // Grabbing the context to set up the drop shadow
    CGContextSaveGState(currentContext);
    CGContextSetShadow(currentContext, CGSizeMake(4, 7), 3);
    // Drawing the image on top (hopfully)
    [logoImage drawInRect:imageBounds];
    CGContextRestoreGState(currentContext);
}


@end
