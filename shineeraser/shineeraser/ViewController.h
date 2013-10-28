//
//  ViewController.h
//  shineeraser
//
//  Created by Shane Dickson on 9/5/13.
//  Copyright (c) 2013 Shane Dickson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppController.h"

@interface ViewController : UIViewController<UIScrollViewDelegate>
{

    CGPoint firstEyeLocation;
    CGPoint secondEyeLocation;
    
    
    
}

@property (assign) BOOL didSelectImage;

@property (nonatomic, strong) IBOutlet UIImageView* imageView;
@property (nonatomic, strong) IBOutlet UIScrollView* scrollView;


-(IBAction)selectPhotos:(id)sender;


-(IBAction)handleTap:(id)sender;
-(IBAction)handlePinchToZoom:(id)sender;

-(IBAction)removeShine:(id)sender;

-(IBAction)reset:(id)sender;

@end
