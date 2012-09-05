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


// This only gets called when it's decoded.
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {

        self.lineRect = [aDecoder decodeCGRectForKey:@"lineRect"];
    }
    
    return self;
}


+(Line*)generateHorizontalLineWithBounds:(CGRect)viewBounds{
    Line* line = [Line new];
    float x = arc4random()%(int)viewBounds.size.width+80;
    float y = arc4random()%(int)viewBounds.size.height+80;
    float length = (arc4random()%200)+50;
    line.lineRect = CGRectMake(x, y, 5.0, length);
    return line;
}


+(Line*)generateVerticalLineWithBounds:(CGRect)viewBounds{
    Line* line = [Line new];
    float x = arc4random()%(int)viewBounds.size.width+80;
    float y = arc4random()%(int)viewBounds.size.height+80;
    float height = (arc4random()%200)+50;
    line.lineRect = CGRectMake(x, y, height, 5.0);
    return line;
}

-(void)drawLineWithContext:(CGContextRef)ctx{
    CGContextFillRect(ctx, self.lineRect);
}



//encoding methods:
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeCGRect:self.lineRect forKey:@"lineRect"]; 
}

-(NSString*)description {
    return [NSString stringWithFormat:@"%@", NSStringFromCGRect(self.lineRect)];
}

@end
