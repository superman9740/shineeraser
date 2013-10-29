//
//  CropViewController.h
//  shineeraser
//
//  Created by sdickson on 10/28/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"
#import "YKImageCropperViewController.h"

@interface CropViewController : UIViewController
{
    
    
}


@property (nonatomic, strong) YKImageCropperViewController* imageCropperViewController;

@property (nonatomic, strong) IBOutlet UIView* cropView;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;


-(IBAction)save:(id)sender;

@end
