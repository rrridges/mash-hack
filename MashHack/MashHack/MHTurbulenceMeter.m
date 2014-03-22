//
//  MHTurbulenceMeter.m
//  MashHack
//
//  Created by Matt Bridges on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import "MHTurbulenceMeter.h"

#define MOTION_QUEUE_SIZE 10
#define MAX_G_FORCE 15

NSString * const kMHTurbulenceUpdateNotification = @"kMHTurbulenceUpdateNotification";
NSString * const KMHTurbulenceUpdateNotificationMagnitudeKey = @"kMHTurbulenceUpdateNotificationMagnitudeKey";

@interface MHTurbulenceMeter ()
@property (strong, nonatomic) NSMutableArray *motionQueue;
- (void)handleMotionUpdate:(CMDeviceMotion *)motion;
- (void)addMotionToQueue:(CMDeviceMotion *)motion;
@end

@implementation MHTurbulenceMeter

- (instancetype)init {
    if (self = [super init]) {
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.deviceMotionUpdateInterval = 0.25;
        self.motionQueue = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)start {
    __weak id weakSelf = self;
    [self.motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *motion, NSError *error) {
        if (!error) {
            [weakSelf handleMotionUpdate:motion];
        }
    }];
}

- (void)handleMotionUpdate:(CMDeviceMotion *)motion {
    [self addMotionToQueue:motion];

    double diffTotal = 0;
    
    for (int i = 0; i < self.motionQueue.count - 1; i++) {
        CMDeviceMotion *motion1 = self.motionQueue[i];
        CMDeviceMotion *motion2 = self.motionQueue[i+1];
        
        double diffX = motion1.userAcceleration.x - motion2.userAcceleration.x;
        double diffY = motion1.userAcceleration.y - motion2.userAcceleration.y;
        double diffZ = motion1.userAcceleration.z - motion2.userAcceleration.z;
        
        double magnitude = sqrt(diffX * diffX + diffY * diffY + diffZ * diffZ);
        diffTotal += magnitude;
    }
    
    double avgDiff = diffTotal / self.motionQueue.count;
    double magnitude = (avgDiff > MAX_G_FORCE ? MAX_G_FORCE : avgDiff) / MAX_G_FORCE;
    
//    NSLog(@"x: %f", motion.userAcceleration.x);
//    NSLog(@"y: %f", motion.userAcceleration.y);
//    NSLog(@"z: %f", motion.userAcceleration.z);
//    NSLog(@"avgDiff: %f", avgDiff);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kMHTurbulenceUpdateNotification
                                                        object:self
                                                      userInfo:@{KMHTurbulenceUpdateNotificationMagnitudeKey : @(magnitude)}];
}

- (void)addMotionToQueue:(CMDeviceMotion *)motion {
    [self.motionQueue addObject:motion];
    if (self.motionQueue.count > MOTION_QUEUE_SIZE) {
        NSRange range;
        range.location = self.motionQueue.count - MOTION_QUEUE_SIZE;
        range.length = MOTION_QUEUE_SIZE;
        [self.motionQueue removeObjectAtIndex:0];
    }
}




@end
