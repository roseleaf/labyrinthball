//
//  Line.m
//  LabyrinthBall
//
//  Created by Rose CW on 9/4/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import "Line.h"
#import "LabyrinthView.h"


@implementation Line
+(Line*)generateHorizontalLineWithBounds:(CGRect)viewBounds{
    Line* line = [Line new];
    float x = arc4random()%(int)viewBounds.size.width;
    float y = arc4random()%(int)viewBounds.size.height;
    float length = arc4random()%150;
    line.lineRect = CGRectMake(x, y, 5.0, length);
    return line;
}


+(Line*)generateVerticalLineWithBounds:(CGRect)viewBounds{
    Line* line = [Line new];
    float x = arc4random()%(int)viewBounds.size.width;
    float y = arc4random()%(int)viewBounds.size.height;
    float height = arc4random()%150;
    line.lineRect = CGRectMake(x, y, height, 5.0);
    return line;
}

-(void)drawLineWithContext:(CGContextRef)ctx{
    CGContextFillRect(ctx, self.lineRect);
}

@end
