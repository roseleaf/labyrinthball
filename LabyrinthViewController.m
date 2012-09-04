//
//  LabyrinthViewController.m
//  LabyrinthBall
//
//  Created by Rose CW on 9/3/12.
//  Copyright (c) 2012 Rose and Liam. All rights reserved.
//

#import "LabyrinthViewController.h"
#import "LabyrinthView.h"
#import <CoreMotion/CoreMotion.h>

@interface LabyrinthViewController ()
@property CMMotionManager* motionManager;
@property LabyrinthView* labyrinthView;
@end

@implementation LabyrinthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.motionManager = [CMMotionManager new];
        [self.motionManager startDeviceMotionUpdates];
        self.motionManager.deviceMotionUpdateInterval = 1.0/60.0;
        
        if (self.motionManager.deviceMotionAvailable) {
            NSLog(@"Device Motion is Available");
             [NSTimer scheduledTimerWithTimeInterval:(1.0/60.0) target:self selector:@selector(getMotionData) userInfo:nil repeats:YES];
        }

    }
    return self;
}

-(void)loadView{
    self.labyrinthView = [[LabyrinthView alloc]initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    self.view = self.labyrinthView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)getMotionData{
    CMDeviceMotion *currentMotion = self.motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentMotion.attitude;
    float roll = currentAttitude.roll;
    float pitch = currentAttitude.pitch;
    
//    NSLog(@"roll: %f", roll);
//    NSLog(@"pitch: %.2f", pitch);

    
    [self.labyrinthView animateBallWithRoll:(float)roll andWithPitch:(float)pitch];
}


-(void)checkForCollisions{
    
    
//    if(CGRectContainsPoint(self.labyrinthView.line, self.labyrinthView.ballLocationCenter)) {
//        NSLog(@"Labyrinth View Origin X: %f",self.labyrinthView.line.origin.x);
//        NSLog(@"Labyrinth View Origin y: %f",self.labyrinthView.line.origin.y);
//        NSLog(@"Labyrinth View Origin y: %f",self.labyrinthView.ballLocationCenter.x);
//        NSLog(@"Labyrinth View Origin y: %f",self.labyrinthView.ballLocationCenter.y);
//        
//        
//        float circleX = self.labyrinthView.ballLocationCenter.x;
//        float circleY = self.labyrinthView.ballLocationCenter.y;
//        
//    if ((circleX < self.labyrinthView.line.origin.x) | (circleX > (self.labyrinthView.line.origin.x + self.labyrinthView.line.size.width)) | (circleY < self.labyrinthView.line.origin.y) | (circleY > (self.labyrinthView.line.origin.y + self.labyrinthView.line.size.height))) {
//        
//    } else {
//        NSLog(@"Intersecting the wall");
//    }

        
        
//    }
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
