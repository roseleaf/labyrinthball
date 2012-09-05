//
//  LabyrinthView.m
//  LabyrinthBall
//
//  Created by Rose CW on 9/3/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import "LabyrinthView.h"
#import <QuartzCore/QuartzCore.h>
#import "Line.h"

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
        
        //create lines:
        self.lineArray = [NSMutableArray new];
        for (int i = 0; i<=5; i++) {
            Line* line = [Line generateHorizontalLineWithBounds:self.bounds];
            [self.lineArray addObject:line];
        }
        for (int i = 0; i<=5; i++) {
            Line* line = [Line generateVerticalLineWithBounds:self.bounds];
            [self.lineArray addObject:line];
        }

        self.birdLayer = [CALayer new];
        
        
        UIImage *bird = [UIImage imageNamed:@"bluebird.png"];
        UIImage *opponentBird = [UIImage imageNamed:@"redbird.png"];

        
        self.birdLayer.bounds = CGRectMake(50, 50, 40, 30);
        self.birdLayer.contents = (__bridge id)[bird CGImage];
        [self.layer addSublayer:self.birdLayer];

        self.opponentBirdLayer.bounds = CGRectMake(50, 50, 40, 30);
        self.opponentBirdLayer.contents = (__bridge id)[opponentBird CGImage];
        [self.layer addSublayer:self.opponentBirdLayer];
        

    }
    return self;
}




- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor brownColor]set];

    for (Line* line in self.lineArray){
        [line drawLineWithContext:ctx];
    }
}


//-(void)createLineForContext:(CGContextRef)ctx withRect:(CGRect)rect {
//    [[UIColor redColor]set];
////    self.line = CGRectMake(150.0, 240.0, 20.0, 5.0);
//    CGContextFillRect(ctx, rect);
////    CGContextFillPath(ctx);
//}

//-(void)createBallForContext:(CGContextRef)ctx {
//    [[UIColor blackColor]set];
//    CGContextAddArc(ctx, self.ballLocationCenter.x, self.ballLocationCenter.y, 10.0, 0.0, M_PI*2, YES);
//    CGContextFillPath(ctx);
//}

-(void)animateBallWithRoll:(float)roll andWithPitch:(float)pitch {

    BOOL intersectsAnyLine = NO;
    
    CGPoint newLocation;
    float x = self.birdLayer.position.x + roll;
    float y = self.birdLayer.position.y + pitch;
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
    
    CGRect birdMoveRect = CGRectMake(newLocation.x, newLocation.y, 15, 25);
        
    if ([self isInvalidNextMove:birdMoveRect]) {
        intersectsAnyLine = YES;
        //Only use the roll
        CGRect birdMoveRect = CGRectMake(newLocation.x, self.birdLayer.position.y, 15, 25);
        if ([self isInvalidNextMove:birdMoveRect]) {
            //Only use pitch
            intersectsAnyLine = YES;
            CGRect birdMoveRect = CGRectMake(self.birdLayer.position.x, newLocation.y, 15, 25);
            if ([self isInvalidNextMove:birdMoveRect]) {
                intersectsAnyLine = YES;
            } else {
                intersectsAnyLine = NO;
            }
        } else {
            intersectsAnyLine = NO;
        }

    } else {
        intersectsAnyLine = NO;
    }
    
    if (!intersectsAnyLine){
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.birdLayer.position = newLocation;
        [CATransaction commit];
    }
}

-(BOOL)isInvalidNextMove:(CGRect)birdMoveRect {
    BOOL intersectsAnyLine = NO;
    for (Line *line in self.lineArray) {
        if (CGRectIntersectsRect (line.lineRect, birdMoveRect)) {
            intersectsAnyLine = YES;
        }
    }
    return intersectsAnyLine;
}


@end
