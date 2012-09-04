//
//  LabyrinthView.m
//  LabyrinthBall
//
//  Created by Rose CW on 9/3/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import "LabyrinthView.h"
#import <QuartzCore/QuartzCore.h>


@interface LabyrinthView ()

@end


@implementation LabyrinthView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setNeedsDisplay];
        // Initialization code
        [self setBackgroundColor:[UIColor whiteColor]];
//        newLocation = CGPointMake(50.0, 50.0);
        self.birdLayer = [CALayer new];
        
        
        UIImage *bird = [UIImage imageNamed:@"bird.png"];

        self.birdLayer.bounds = CGRectMake(50, 50, 40, 40);
//        self.birdLayer.position = newLocation;
        self.birdLayer.contents = (__bridge id)[bird CGImage];
        [self.layer addSublayer:self.birdLayer];

    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    [self createBallForContext:ctx];
    [self createLineForContext:ctx];
    
    

}

-(void)createLineForContext:(CGContextRef)ctx {
    [[UIColor redColor]set];
    self.line = CGRectMake(150.0, 240.0, 20.0, 5.0);
    CGContextFillRect(ctx, self.line);
//    CGContextFillPath(ctx);
}

//-(void)createBallForContext:(CGContextRef)ctx {
//    [[UIColor blackColor]set];
//    CGContextAddArc(ctx, self.ballLocationCenter.x, self.ballLocationCenter.y, 10.0, 0.0, M_PI*2, YES);
//    CGContextFillPath(ctx);
//}

-(void)animateBallWithRoll:(float)roll andWithPitch:(float)pitch {
//    NSLog(@"The roll is %f and the pitch is %f", roll, pitch);

    CGPoint newLocation;
    float x = self.birdLayer.position.x + roll *10;
    float y = self.birdLayer.position.y + pitch *10;
    if (x < 10.0) {
        x = 10.0; } else if (x > (self.bounds.size.width - 10.0)) {
            x = (self.bounds.size.width - 10.0);
        }
    if (y < 10.0) {
        y = 10.0;
    } else if (y > (self.bounds.size.height - 10.0)){
        y = (self.bounds.size.height - 10.0);
    }
    newLocation = CGPointMake(x, y);
    
    CGRect birdMoveRect = CGRectMake(newLocation.x-15, newLocation.y-15, 15, 25);
    
    if (CGRectIntersectsRect (self.line, birdMoveRect)) {
//        self.birdLayer.position = self.birdLayer.position;
    } else {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.birdLayer.position = newLocation;
        [CATransaction commit];
    }
    // if (checkForIntersection:(CGPoint)self.birdLocation) {
            //self.birdLayer.position = self.birdLayer.position
        // else
            // self.birdLayer.position = newLocation;
}

-(BOOL)checkForIntersection:(CGPoint)birdLocation {
    BOOL intersect = NO;
}



//-(void)stopBirdFromHittingWall{
//    if (line.) {
//        <#statements#>
//    }
//}


@end
