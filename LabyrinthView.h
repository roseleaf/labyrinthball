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
@property (strong) CALayer* birdLayer;
@property (strong) CALayer* opponentBirdLayer;
@property (strong) NSMutableArray* lineArray;
@property CGPoint birdPosition;

@end
