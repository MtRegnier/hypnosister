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
    
    // Drawing the image on top (hopfully)
    [logoImage drawInRect:bounds];
    
}


@end
