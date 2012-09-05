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
#import <GameKit/GameKit.h>


@interface LabyrinthViewController () <GKSessionDelegate, GKPeerPickerControllerDelegate>
@property CMMotionManager* motionManager;
@property LabyrinthView* labyrinthView;
@property GKSession* session;
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
        
        GKPeerPickerController* picker = [[GKPeerPickerController alloc] init];
        picker.delegate = self;
        picker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
        [picker show];

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
    
}




////GamkeKit Delegate Methods:
//-(void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
//    [self.session acceptConnectionFromPeer:peerID error:nil];
//    session.available = NO;
//    NSLog(@"connectingClient:%@", peerID);
//}
//
-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
    if (state==GKPeerStateConnected) {
        NSLog(@"Connected to peer %@", peerID);
    }
}



-(void)receiveData:(NSData*)data fromPeer:(NSString*) peer inSession:(GKSession*)session context:(void*)context {
    
    NSLog(@"%@", data);
}

//-(void)receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context {
//    
//    NSString* message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    [[[UIAlertView alloc] initWithTitle:peer message:message delegate:self cancelButtonTitle:@"Accept" otherButtonTitles:nil] show];
//}


//GKPeerPicker Delegate Methods:
- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type{
    //Tells the delegate that the user selected a connection type.

}

-(GKSession*)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type{
    return self.session;
    
}


-(void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    self.session = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    picker.delegate = nil;
    [picker dismiss];
    NSLog(@"did Connect to Peer: %@", peerID);
}

-(void)session:(GKSession *)session didFailWithError:(NSError *)error{
    NSLog(@"%@", error);
}




//CoreMotion Method for Device Orientation:
-(void)getMotionData{
    CMDeviceMotion *currentMotion = self.motionManager.deviceMotion;
    CMAttitude *currentAttitude = currentMotion.attitude;
    float roll = currentAttitude.roll;
    float pitch = currentAttitude.pitch;
    
    [self.labyrinthView animateBallWithRoll:(float)roll andWithPitch:(float)pitch];
}



//Defaults:
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
