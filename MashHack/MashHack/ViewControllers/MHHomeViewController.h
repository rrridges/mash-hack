//
//  MHHomeViewController.h
//  MashHack
//
//  Created by Ross LeBeau on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHHomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *meterDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *mildLabel;
@property (weak, nonatomic) IBOutlet UILabel *severeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *alert1;
@property (weak, nonatomic) IBOutlet UIImageView *alert2;
@property (weak, nonatomic) IBOutlet UIImageView *alert3;
@property (weak, nonatomic) IBOutlet UIScrollView *alertScrollView;
@property (weak, nonatomic) IBOutlet UILabel *meterTitleLabel;

@end
