//
//  ViewController.h
//  shineeraser
//
//  Created by Shane Dickson on 9/5/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{

    CGPoint firstEyeLocation;
    CGPoint secondEyeLocation;
    
    
    
}

@property (assign) BOOL didSelectImage;

@property (nonatomic, strong) IBOutlet UIImageView* imageView;


-(IBAction)selectPhotos:(id)sender;


-(IBAction)handleTap:(id)sender;


-(IBAction)removeShine:(id)sender;

@end
