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

        self.labyrinthView = [LabyrinthView new];
        self.view = self.labyrinthView;
        
        if (self.motionManager.deviceMotionAvailable) {
            NSLog(@"Device Motion is Available");
             [NSTimer scheduledTimerWithTimeInterval:(1.0/60.0) target:self selector:@selector(getMotionData) userInfo:nil repeats:YES];
        }

    }
    return self;
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


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
