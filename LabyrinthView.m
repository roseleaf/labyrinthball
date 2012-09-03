//
//  LabyrinthView.m
//  LabyrinthBall
//
//  Created by Rose CW on 9/3/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import "LabyrinthView.h"
@interface LabyrinthView ()
@property CGPoint ballLocationCenter;
@end


@implementation LabyrinthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsDisplay];
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
        self.ballLocationCenter = CGPointMake(20.0, 20.0);
    }
    return self;
}


- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    ctx = [self createBallForContext:ctx];
//    CGRect imageRect = CGRectMake(self.ballLocationCenter.x, self.ballLocationCenter.y, 50.0, 50.0);
//    UIImage *bird = [UIImage imageNamed:@"bird.png"];
//    CGContextDrawImage(ctx, imageRect, bird.CGImage);
    
    CGContextFillPath(ctx);
}

-(CGContextRef *)createBallForContext:(CGContextRef)ctx {
    [[UIColor blackColor]set];
    CGContextAddArc(ctx, self.ballLocationCenter.x, self.ballLocationCenter.y, 10.0, 0.0, M_PI*2, YES);
    NSLog(@"x = %f, y = %f", self.ballLocationCenter.x, self.ballLocationCenter.y);
}

-(void)animateBallWithRoll:(float)roll andWithPitch:(float)pitch {
//    NSLog(@"The roll is %f and the pitch is %f", roll, pitch);

    float x = self.ballLocationCenter.x + roll * 10;
    float y = self.ballLocationCenter.y + pitch * 10;
    if (x < 0.0) {
        x = 0.0; } else if (x > self.bounds.size.width) {
            x = self.bounds.size.width;
        }
    if (y < 0.0) {
        y = 0.0;
    } else if (y > self.bounds.size.height){
        y = self.bounds.size.height;
    }
    self.ballLocationCenter = CGPointMake(x, y);
    [self setNeedsDisplay];
}

@end
