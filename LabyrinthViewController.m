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
        
        self.session = [[GKSession alloc] initWithSessionID:@"applepie27" displayName:@"Bird1" sessionMode:GKSessionModePeer];
        [self.session setDataReceiveHandler:self withContext:nil]; 
        self.session.delegate = self;
        self.session.available = YES;

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




//GamkeKit Delegate Methods:
-(void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID{
    [self.session acceptConnectionFromPeer:peerID error:nil];
    session.available = NO;
    NSLog(@"connectingClient:%@", peerID);
}

-(void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
    if (state==GKPeerStateAvailable) {
        NSLog(@"Connecting to peer %@", peerID);
        [session connectToPeer:peerID withTimeout:3];
    }
    else if (state == GKPeerStateConnected){
        NSLog(@"Connected to peer %@", peerID);
        session.available = NO;
    }
}

-(void)receiveData:(NSData*)data fromPeer:(NSString*) peer inSession:(GKSession*)session andContext:(void*)context {
    NSLog(@"%@", data);
}


//GKPeerPicker Delegate Methods:
- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type{
    //Tells the delegate that the user selected a connection type.

}

//-(GKSession*)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type{
//    
//}


-(void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
    self.session = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    picker.delegate = nil;
    [picker dismiss];
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
