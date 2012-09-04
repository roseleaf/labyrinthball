//
//  Line.h
//  LabyrinthBall
//
//  Created by Rose CW on 9/4/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Line : NSObject

@property CGRect lineRect;

+(Line*)generateHorizontalLineWithBounds:(CGRect)viewBounds;
+(Line*)generateVerticalLineWithBounds:(CGRect)viewBounds;
-(void)drawLineWithContext:(CGContextRef)ctx;
@end
