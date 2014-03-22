//
//  MHHomeViewController.m
//  MashHack
//
//  Created by Ross LeBeau on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import "MHHomeViewController.h"
#import "MHSemiDonut.h"

@interface MHHomeViewController ()

@property (nonatomic, weak) IBOutlet UIView *turbulenceMeterContainer;
@property (nonatomic, weak) IBOutlet UIImageView *turbulenceMeterBgMask;
@property (nonatomic, weak) IBOutlet UIView *rotatorRect;

@end

@implementation MHHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIView *meterBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.turbulenceMeterContainer.frame.size.width - 20, self.turbulenceMeterContainer.frame.size.height - 20)];
    meterBg.backgroundColor = UIColorFromRGB(0x3a48ab);
    self.rotatorRect.layer.anchorPoint = CGPointMake(0.5, 0);
    self.rotatorRect.layer.position = CGPointMake(148, 169);
    
    [self.turbulenceMeterContainer insertSubview:meterBg belowSubview:self.rotatorRect];
    
    self.rotatorRect.backgroundColor = UIColorFromRGB(0x68b7ef);
    
    [UIView animateWithDuration:1.5 animations:^{
        self.rotatorRect.transform = CGAffineTransformRotate(self.rotatorRect.transform, 0.5*(M_PI / 2));
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
