//
//  MHHomeViewController.m
//  MashHack
//
//  Created by Ross LeBeau on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import "MHHomeViewController.h"
#import "MHSemiDonut.h"
#import "MHTurbulenceMeter.h"

@interface MHHomeViewController ()

@property (nonatomic, weak) IBOutlet UIView *turbulenceMeterContainer;
@property (nonatomic, weak) IBOutlet UIImageView *turbulenceMeterBgMask;
@property (nonatomic, weak) IBOutlet UIView *rotatorRect;
@property (nonatomic, strong) UIImageView *meterArrow;

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
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(turbulenceUpdated:) name:kMHTurbulenceUpdateNotification object:nil];
    self.turbulenceMeterContainer.layer.cornerRadius = 10;
    
    UIView *meterBg = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.turbulenceMeterContainer.frame.size.width - 20, self.turbulenceMeterContainer.frame.size.height - 20)];
    meterBg.backgroundColor = UIColorFromRGB(0x3a48ab);
    self.rotatorRect.layer.anchorPoint = CGPointMake(0.5, 0);
    self.rotatorRect.layer.position = CGPointMake(148, 171);
    
    [self.turbulenceMeterContainer insertSubview:meterBg belowSubview:self.rotatorRect];
    
    self.rotatorRect.backgroundColor = UIColorFromRGB(0x68b7ef);
    
    UIFont *font = [UIFont fontWithName:@"ProximaNova-Regular" size:12];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    [paragraphStyle setLineSpacing: 3.0];
    [paragraphStyle setAlignment:NSTextAlignmentCenter];
    
    NSDictionary *attributes = @{ NSFontAttributeName: font, NSParagraphStyleAttributeName: paragraphStyle };
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"Clear-air turbulence is the movement of air masses in the absence of any visual cues (such as clouds), and is caused when bodies of air moving at widely different speeds meet." attributes:attributes];
    
    [self.meterDescriptionLabel setAttributedText: attributedString];
    
    self.mildLabel.font = [UIFont fontWithName:@"ProximaNovaCond-Regular" size:12];
    self.severeLabel.font = [UIFont fontWithName:@"ProximaNovaCond-Regular" size:12];
    
    self.meterArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meter_arrow.png"]];
    [self.turbulenceMeterContainer addSubview:self.meterArrow];
    self.meterArrow.layer.anchorPoint = CGPointMake(0.5, 18.0/27.0);
    self.meterArrow.layer.position = CGPointMake(148, 166);
    self.meterArrow.transform = CGAffineTransformMakeRotation(-M_PI_2);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)turbulenceUpdated:(NSNotification *)notification {
    double magnitude = [notification.userInfo[KMHTurbulenceUpdateNotificationMagnitudeKey] doubleValue];
//    NSLog(@"magnitude: %f", magnitude);
    
    float angle = M_PI * magnitude;
    [self.rotatorRect.layer removeAllAnimations];
    [UIView animateWithDuration:0.3 animations:^{
        self.rotatorRect.transform = CGAffineTransformRotate(CGAffineTransformIdentity, angle);
        self.meterArrow.transform = CGAffineTransformRotate(CGAffineTransformMakeRotation(-M_PI_2), angle);
    }];
}

- (void)viewTapped:(UITapGestureRecognizer *)tap {
    if (self.alert1.hidden) {
        
        self.alert1.alpha = 0;
        self.alert1.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.alert1.alpha = 1;
        }];
    } else if (self.alert2.hidden) {
        self.alertScrollView.contentSize = CGSizeMake(320, 640);
        self.alert2.alpha = 0;
        self.alert2.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.alert1.transform = CGAffineTransformMakeTranslation(0, 120);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.alert2.alpha = 1;
            }];
        }];
    } else if (self.alert3.hidden) {
        self.alertScrollView.contentSize = CGSizeMake(320, 760);
        self.alert3.alpha = 0;
        self.alert3.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            self.alert1.transform = CGAffineTransformTranslate(self.alert1.transform, 0, 120);
            self.alert2.transform = CGAffineTransformTranslate(self.alert2.transform, 0, 120);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.alert3.alpha = 1;
            }];
        }];
    } else {
        self.alertScrollView.contentSize = CGSizeMake(320, 568);
        self.alert1.hidden = YES;
        self.alert2.hidden = YES;
        self.alert3.hidden = YES;
        self.alert1.transform = CGAffineTransformIdentity;
        self.alert2.transform = CGAffineTransformIdentity;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
