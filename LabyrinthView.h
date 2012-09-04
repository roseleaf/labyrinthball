//
//  LabyrinthView.h
//  LabyrinthBall
//
//  Created by Rose CW on 9/3/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LabyrinthView : UIView
-(void)animateBallWithRoll:(float)roll andWithPitch:(float)pitch;

@property CGRect line;
@property CGPoint newLocation;

@property CALayer* birdLayer;

@end
