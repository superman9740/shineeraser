//
//  SettingsViewController.h
//  shineeraser
//
//  Created by sdickson on 10/30/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"

@interface SettingsViewController : UIViewController
{
    
    float circleSize;
    
}

@property (nonatomic, strong) IBOutlet UIStepper* stepper;
@property (nonatomic, strong) IBOutlet UILabel* stepperText;


-(IBAction)changeCircleSize:(id)sender;

@end
