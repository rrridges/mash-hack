//
//  MHSemiDonut.m
//  MashHack
//
//  Created by Ross LeBeau on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import "MHSemiDonut.h"

@interface MHSemiDonut()

@property (nonatomic, strong) UIView *rotatorRect;

@end

@implementation MHSemiDonut

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (void)setup {
    self.backgroundColor = [UIColor redColor];
    
    UIImageView *donutMask = [[UIImageView alloc] initWithImage:@"donutMask"];
    [self addSubview:donutMask];
    
    self.rotatorRect = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height, self.frame.size.width, self.frame.size.height / 2)];
    [self addSubview:self.rotatorRect];
}

#pragma mark - Public Methods

- (void)animateToPercent:(CGFloat)percent {
    return;
    CGFloat angle = percent * (M_PI);
    [UIView animateWithDuration:0.3 animations:^{
        self.rotatorRect.transform = CGAffineTransformRotate(self.rotatorRect.transform, angle);
    }];
}

@end
