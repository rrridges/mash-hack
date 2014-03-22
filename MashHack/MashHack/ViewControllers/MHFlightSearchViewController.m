//
//  MHFlightSearchViewController.m
//  MashHack
//
//  Created by Ross LeBeau on 3/22/14.
//  Copyright (c) 2014 Intrepid. All rights reserved.
//

#import "MHFlightSearchViewController.h"
#import "MHFlightViewController.h"

@interface MHFlightSearchViewController () <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *airlineField;
@property (nonatomic, weak) IBOutlet UITextField *flightNumberField;
@property (nonatomic, weak) IBOutlet UITextField *dateField;

@end

@implementation MHFlightSearchViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:tap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate Methods

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.airlineField) {
        [self.flightNumberField becomeFirstResponder];
    } else if (textField == self.flightNumberField) {
        [self.dateField becomeFirstResponder];
    } else if (textField == self.dateField) {
        MHFlightViewController *flightVC = [[MHFlightViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:flightVC animated:YES];
    }
    
    return YES;
}

- (void)viewTapped:(UITapGestureRecognizer *)tap {
    [self.view endEditing:YES];
}

@end
