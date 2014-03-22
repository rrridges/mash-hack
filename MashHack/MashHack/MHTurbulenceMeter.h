//
//  MHTurbulenceMeter.h
//  MashHack
//
//  Created by Matt Bridges on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

extern NSString * const kMHTurbulenceUpdateNotification;
extern NSString * const KMHTurbulenceUpdateNotificationMagnitudeKey;

@interface MHTurbulenceMeter : NSObject
@property (strong, nonatomic) CMMotionManager *motionManager;

- (void)start;
@end
