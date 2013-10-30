//
//  SettingsViewController.m
//  shineeraser
//
//  Created by sdickson on 10/30/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
	
}

-(void)viewWillAppear:(BOOL)animated
{
    _stepper.value = [[AppController sharedInstance] circleSize];
    _stepperText.text = [NSString stringWithFormat:@"%.2f", _stepper.value];
    
}
-(IBAction)changeCircleSize:(UIStepper*)sender
{
    
    double value = [sender value];
    
    
    [[AppController sharedInstance] setCircleSize:value];
    _stepperText.text = [NSString stringWithFormat:@"%.2f", value];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
